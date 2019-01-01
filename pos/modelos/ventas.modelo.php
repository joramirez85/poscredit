<?php

require_once "conexion.php";

class ModeloVentas{

	/*=============================================
	MOSTRAR VENTAS
	=============================================*/

	static public function mdlMostrarVentas($tabla, $item, $valor){

		if($item != null){

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE $item = :$item ORDER BY id ASC");

			$stmt -> bindParam(":".$item, $valor, PDO::PARAM_STR);

			$stmt -> execute();

			return $stmt -> fetch();

		}else{

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla ORDER BY id ASC");

			$stmt -> execute();

			return $stmt -> fetchAll();

		}
		
		$stmt -> close();

		$stmt = null;

	}

	/*=============================================
	REGISTRO DE VENTA
	=============================================*/

	static public function mdlIngresarVenta($tabla, $datos){
		$pdo = Conexion::conectar();
		$pdo->beginTransaction();

		$stmt = $pdo->prepare("INSERT INTO $tabla(codigo, id_cliente, id_vendedor, productos, impuesto, neto, total, metodo_pago) VALUES (:codigo, :id_cliente, :id_vendedor, :productos, :impuesto, :neto, :total, :metodo_pago)");
		$stmt->bindParam(":codigo", $datos["codigo"], PDO::PARAM_INT);
		$stmt->bindParam(":id_cliente", $datos["id_cliente"], PDO::PARAM_INT);
		$stmt->bindParam(":id_vendedor", $datos["id_vendedor"], PDO::PARAM_INT);
		$stmt->bindParam(":productos", $datos["productos"], PDO::PARAM_STR);
		$stmt->bindParam(":impuesto", $datos["impuesto"], PDO::PARAM_STR);
		$stmt->bindParam(":neto", $datos["neto"], PDO::PARAM_STR);
		$stmt->bindParam(":total", $datos["total"], PDO::PARAM_STR);
		$stmt->bindParam(":metodo_pago", $datos["metodo_pago"], PDO::PARAM_STR);

		// ES UNA VENTA A CREDITO
		if (isset($datos['financiamiento'])) {
			if ($stmt->execute()) {
				$id_venta = $pdo->lastInsertId();
				$financiamiento = $datos['financiamiento'];
				$stmt2 = $pdo->prepare("INSERT INTO ventas_credito(id_venta, metodo_pago_inicial, codigo_transaccion, monto_pago_inicial, monto_financiado, monto_cada_pago, frecuencia_pagos, cantidad_pagos, fecha_primer_pago) VALUES (:id_venta, :metodo_pago_inicial, :codigo_transaccion, :monto_pago_inicial, :monto_financiado, :monto_cada_pago, :frecuencia_pagos, :cantidad_pagos, :fecha_primer_pago)");
				
				$stmt2->bindParam(":id_venta", $id_venta, PDO::PARAM_INT);
				$stmt2->bindParam(":metodo_pago_inicial", $financiamiento["metodo_pago_inicial"], PDO::PARAM_STR);
				$stmt2->bindParam(":codigo_transaccion", $financiamiento["codigo_transaccion"], PDO::PARAM_STR);
				$stmt2->bindParam(":monto_pago_inicial", $financiamiento["monto_pago_inicial"], PDO::PARAM_STR);
				$stmt2->bindParam(":monto_financiado", $financiamiento["monto_financiado"], PDO::PARAM_STR);
				$stmt2->bindParam(":monto_cada_pago", $financiamiento["monto_cada_pago"], PDO::PARAM_STR);
				$stmt2->bindParam(":frecuencia_pagos", $financiamiento["frecuencia_pagos"], PDO::PARAM_STR);
				$stmt2->bindParam(":cantidad_pagos", $financiamiento["cantidad_pagos"], PDO::PARAM_INT);
				$stmt2->bindParam(":fecha_primer_pago", $financiamiento["fecha_primer_pago"], PDO::PARAM_STR);
				
				if (!$stmt2->execute()) {
					$pdo->rollback();
					$error = $stmt2->errorInfo();
					return "Error (1): ({$error[0]} - {$error[1]}) {$error[2]}";
				}
				else {
					$id_venta_credito = $pdo->lastInsertId();
					for ($i = 0; $i < $financiamiento["cantidad_pagos"]; $i++) {
						$stmt_pagos = $pdo->prepare("INSERT INTO ventas_credito_pagos(
							id_venta_credito,
							monto,
							fecha_cobro_original
						) VALUES (
							:id_venta_credito,
							:monto,
							:fecha_cobro_original
						)");

						if ($i == 0) {
							$fecha_cobro_original = $financiamiento['fecha_primer_pago'];
						}
						else {
							$dias = '';
							if ($financiamiento['frecuencia_pagos'] == 'semanal') {
								$dias = '+7 day';
							}
							if ($financiamiento['frecuencia_pagos'] == 'quincenal') {
								$dias = '+14 day';
							}
							if ($financiamiento['frecuencia_pagos'] == 'mensual') {
								$dias = '+28 day';
							}
							$fecha_cobro_original = strtotime($dias, strtotime($fecha_cobro_original));;
							$fecha_cobro_original = date('Y-m-d', $fecha_cobro_original);
						}

						$stmt_pagos->bindParam(":id_venta_credito", $id_venta_credito, PDO::PARAM_INT);
						$stmt_pagos->bindParam(":monto", $financiamiento['monto_cada_pago'], PDO::PARAM_STR);
						$stmt_pagos->bindParam(":fecha_cobro_original", $fecha_cobro_original, PDO::PARAM_STR);
						if (!$stmt_pagos->execute()) {
							$pdo->rollback();
							$error = $stmt_pagos->errorInfo();
							return "Error (2): ({$error[0]} - {$error[1]}) {$error[2]}";
						}
					}
					$pdo->commit();
					return "ok";
				}
			}
			else {
				$pdo->rollback();
				$error = $stmt->errorInfo();
				return "Error (3): ({$error[0]} - {$error[1]}) {$error[2]}";
			}
		}
		else if ($stmt->execute()) {
				$pdo->commit();
				return "ok";
		}
		else {
			$pdo->rollback();
			$error = $stmt->errorInfo();
			return "Error (4): ({$error[0]} - {$error[1]}) {$error[2]}";
		}

		$stmt->close();
		$stmt = null;

	}

	/*=============================================
	EDITAR VENTA
	=============================================*/

	static public function mdlEditarVenta($tabla, $datos){

		$stmt = Conexion::conectar()->prepare("UPDATE $tabla SET  id_cliente = :id_cliente, id_vendedor = :id_vendedor, productos = :productos, impuesto = :impuesto, neto = :neto, total= :total, metodo_pago = :metodo_pago WHERE codigo = :codigo");

		$stmt->bindParam(":codigo", $datos["codigo"], PDO::PARAM_INT);
		$stmt->bindParam(":id_cliente", $datos["id_cliente"], PDO::PARAM_INT);
		$stmt->bindParam(":id_vendedor", $datos["id_vendedor"], PDO::PARAM_INT);
		$stmt->bindParam(":productos", $datos["productos"], PDO::PARAM_STR);
		$stmt->bindParam(":impuesto", $datos["impuesto"], PDO::PARAM_STR);
		$stmt->bindParam(":neto", $datos["neto"], PDO::PARAM_STR);
		$stmt->bindParam(":total", $datos["total"], PDO::PARAM_STR);
		$stmt->bindParam(":metodo_pago", $datos["metodo_pago"], PDO::PARAM_STR);

		if($stmt->execute()){

			return "ok";

		}else{

			return "error";
		
		}

		$stmt->close();
		$stmt = null;

	}

	/*=============================================
	ELIMINAR VENTA
	=============================================*/

	static public function mdlEliminarVenta($tabla, $datos){

		$stmt = Conexion::conectar()->prepare("DELETE FROM $tabla WHERE id = :id");

		$stmt -> bindParam(":id", $datos, PDO::PARAM_INT);

		if($stmt -> execute()){

			return "ok";
		
		}else{

			return "error";	

		}

		$stmt -> close();

		$stmt = null;

	}

	/*=============================================
	RANGO FECHAS
	=============================================*/	

	static public function mdlRangoFechasVentas($tabla, $fechaInicial, $fechaFinal){

		if($fechaInicial == null){

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla ORDER BY id ASC");

			$stmt -> execute();

			return $stmt -> fetchAll();	


		}else if($fechaInicial == $fechaFinal){

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha like '%$fechaFinal%'");

			$stmt -> bindParam(":fecha", $fechaFinal, PDO::PARAM_STR);

			$stmt -> execute();

			return $stmt -> fetchAll();

		}else{

			$fechaActual = new DateTime();
			$fechaActual ->add(new DateInterval("P1D"));
			$fechaActualMasUno = $fechaActual->format("Y-m-d");

			$fechaFinal2 = new DateTime($fechaFinal);
			$fechaFinal2 ->add(new DateInterval("P1D"));
			$fechaFinalMasUno = $fechaFinal2->format("Y-m-d");

			if($fechaFinalMasUno == $fechaActualMasUno){

				$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinalMasUno'");

			}else{


				$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinal'");

			}
		
			$stmt -> execute();

			return $stmt -> fetchAll();

		}

	}

	static public function mdlRangoFechasVentasAdeudo($tabla, $fechaInicial, $fechaFinal){

		if($fechaInicial == null){

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE metodo_pago='a_credito' ORDER BY id ASC");

			$stmt -> execute();

			return $stmt -> fetchAll();	


		}else if($fechaInicial == $fechaFinal){

			$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha like '%$fechaFinal%' AND metodo_pago='a_credito' ");

			$stmt -> bindParam(":fecha", $fechaFinal, PDO::PARAM_STR);

			$stmt -> execute();

			return $stmt -> fetchAll();

		}else{

			$fechaActual = new DateTime();
			$fechaActual ->add(new DateInterval("P1D"));
			$fechaActualMasUno = $fechaActual->format("Y-m-d");

			$fechaFinal2 = new DateTime($fechaFinal);
			$fechaFinal2 ->add(new DateInterval("P1D"));
			$fechaFinalMasUno = $fechaFinal2->format("Y-m-d");

			if($fechaFinalMasUno == $fechaActualMasUno){

				$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinalMasUno' AND metodo_pago='a_credito' ");

			}else{


				$stmt = Conexion::conectar()->prepare("SELECT * FROM $tabla WHERE fecha BETWEEN '$fechaInicial' AND '$fechaFinal' AND metodo_pago='a_credito' ");

			}
		
			$stmt -> execute();

			return $stmt -> fetchAll();

		}

	}

	/*=============================================
	SUMAR EL TOTAL DE VENTAS
	=============================================*/

	static public function mdlSumaTotalVentas($tabla){	

		$stmt = Conexion::conectar()->prepare("SELECT SUM(neto) as total FROM $tabla");

		$stmt -> execute();

		return $stmt -> fetch();

		$stmt -> close();

		$stmt = null;

	}

	
}