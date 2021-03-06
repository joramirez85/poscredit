/*=============================================
CARGAR LA TABLA DINÁMICA DE VENTAS
=============================================*/

// $.ajax({

// 	url: "ajax/datatable-ventas.ajax.php",
// 	success:function(respuesta){
		
// 		console.log("respuesta", respuesta);

// 	}

// })

$('.tablaVentas').DataTable( {
    "ajax": "ajax/datatable-ventas.ajax.php",
    "deferRender": true,
	"retrieve": true,
	"processing": true,
	 "language": {

			"sProcessing":     "Procesando...",
			"sLengthMenu":     "Mostrar _MENU_ registros",
			"sZeroRecords":    "No se encontraron resultados",
			"sEmptyTable":     "Ningún dato disponible en esta tabla",
			"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_",
			"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0",
			"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix":    "",
			"sSearch":         "Buscar:",
			"sUrl":            "",
			"sInfoThousands":  ",",
			"sLoadingRecords": "Cargando...",
			"oPaginate": {
			"sFirst":    "Primero",
			"sLast":     "Último",
			"sNext":     "Siguiente",
			"sPrevious": "Anterior"
			},
			"oAria": {
				"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
				"sSortDescending": ": Activar para ordenar la columna de manera descendente"
			}

	}

} );

/*=============================================
AGREGANDO PRODUCTOS A LA VENTA DESDE LA TABLA
=============================================*/

$(".tablaVentas tbody").on("click", "button.agregarProducto", function(){

	var idProducto = $(this).attr("idProducto");

	$(this).removeClass("btn-primary agregarProducto");

	$(this).addClass("btn-default");

	var datos = new FormData();
    datos.append("idProducto", idProducto);

     $.ajax({

     	url:"ajax/productos.ajax.php",
      	method: "POST",
      	data: datos,
      	cache: false,
      	contentType: false,
      	processData: false,
      	dataType:"json",
      	success:function(respuesta){

      	    var descripcion = respuesta["descripcion"];
          	var stock = respuesta["stock"];
          	var precio = respuesta["precio_venta"];
			
			var precios_meses = respuesta["precios_meses"];
			var precios_meses_js = JSON.stringify(precios_meses);

          	/*=============================================
          	EVITAR AGREGAR PRODUTO CUANDO EL STOCK ESTÁ EN CERO
          	=============================================*/

          	if(stock == 0){

      			swal({
			      title: "No hay stock disponible",
			      type: "error",
			      confirmButtonText: "¡Cerrar!"
			    });

			    $("button[idProducto='"+idProducto+"']").addClass("btn-primary agregarProducto");

			    return;

          	}

          	$(".nuevoProducto").append(

          	'<div class="row" style="padding:5px 15px">'+

			  '<!-- Descripción del producto -->'+
	          
	          '<div class="col-xs-6" style="padding-right:0px">'+
	          
	            '<div class="input-group">'+
	              
	              '<span class="input-group-addon"><button type="button" class="btn btn-danger btn-xs quitarProducto" idProducto="'+idProducto+'"><i class="fa fa-times"></i></button></span>'+

	              '<input type="text" class="form-control nuevaDescripcionProducto" idProducto="'+idProducto+'" name="agregarProducto" value="'+descripcion+'" data-precios_meses=\'' + precios_meses_js + '\' readonly required>'+

	            '</div>'+

	          '</div>'+

	          '<!-- Cantidad del producto -->'+

	          '<div class="col-xs-3">'+
	            
	             '<input type="number" class="form-control nuevaCantidadProducto" id="nuevaCantidadProducto_' + idProducto + '" name="nuevaCantidadProducto" idProducto="'+idProducto+'" min="1" value="1" stock="'+stock+'" nuevoStock="'+Number(stock-1)+'" required>'+

	          '</div>' +

	          '<!-- Precio del producto -->'+

	          '<div class="col-xs-3 ingresoPrecio" style="padding-left:0px">'+

	            '<div class="input-group">'+

	              '<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>'+
	                 
	              '<input type="text" class="form-control nuevoPrecioProducto" precioReal="'+precio+'" name="nuevoPrecioProducto" value="'+precio+'" readonly required>'+
	 
	            '</div>'+
	             
	          '</div>'+

	        '</div>') 

	        // SUMAR TOTAL DE PRECIOS

	        sumarTotalPrecios()

	        // AGREGAR IMPUESTO

	        agregarImpuesto()

	        // AGRUPAR PRODUCTOS EN FORMATO JSON

	        listarProductos()

	        // PONER FORMATO AL PRECIO DE LOS PRODUCTOS

	        $(".nuevoPrecioProducto").number(true, 2);

      	}

     })

});

/*=============================================
CUANDO CARGUE LA TABLA CADA VEZ QUE NAVEGUE EN ELLA
=============================================*/

$(".tablaVentas").on("draw.dt", function(){

	if(localStorage.getItem("quitarProducto") != null){

		var listaIdProductos = JSON.parse(localStorage.getItem("quitarProducto"));

		for(var i = 0; i < listaIdProductos.length; i++){

			$("button.recuperarBoton[idProducto='"+listaIdProductos[i]["idProducto"]+"']").removeClass('btn-default');
			$("button.recuperarBoton[idProducto='"+listaIdProductos[i]["idProducto"]+"']").addClass('btn-primary agregarProducto');

		}


	}


})


/*=============================================
QUITAR PRODUCTOS DE LA VENTA Y RECUPERAR BOTÓN
=============================================*/

var idQuitarProducto = [];

localStorage.removeItem("quitarProducto");

$(".formularioVenta").on("click", "button.quitarProducto", function(){

	$(this).parent().parent().parent().parent().remove();

	var idProducto = $(this).attr("idProducto");

	/*=============================================
	ALMACENAR EN EL LOCALSTORAGE EL ID DEL PRODUCTO A QUITAR
	=============================================*/

	if(localStorage.getItem("quitarProducto") == null){

		idQuitarProducto = [];
	
	}else{

		idQuitarProducto.concat(localStorage.getItem("quitarProducto"))

	}

	idQuitarProducto.push({"idProducto":idProducto});

	localStorage.setItem("quitarProducto", JSON.stringify(idQuitarProducto));

	$("button.recuperarBoton[idProducto='"+idProducto+"']").removeClass('btn-default');

	$("button.recuperarBoton[idProducto='"+idProducto+"']").addClass('btn-primary agregarProducto');

	if($(".nuevoProducto").children().length == 0){

		$("#nuevoImpuestoVenta").val(0);
		$("#nuevoTotalVenta").val(0);
		$("#totalVenta").val(0);
		$("#nuevoTotalVenta").attr("total",0);

	}else{

		// SUMAR TOTAL DE PRECIOS

    	sumarTotalPrecios()

    	// AGREGAR IMPUESTO
	        
        agregarImpuesto()

        // AGRUPAR PRODUCTOS EN FORMATO JSON

        listarProductos()

	}

})

/*=============================================
AGREGANDO PRODUCTOS DESDE EL BOTÓN PARA DISPOSITIVOS
=============================================*/

var numProducto = 0;

$(".btnAgregarProducto").click(function(){

	numProducto ++;

	var datos = new FormData();
	datos.append("traerProductos", "ok");

	$.ajax({

		url:"ajax/productos.ajax.php",
      	method: "POST",
      	data: datos,
      	cache: false,
      	contentType: false,
      	processData: false,
      	dataType:"json",
      	success:function(respuesta){
      	    
      	    	$(".nuevoProducto").append(

          	'<div class="row" style="padding:5px 15px">'+

			  '<!-- Descripción del producto -->'+
	          
	          '<div class="col-xs-6" style="padding-right:0px">'+
	          
	            '<div class="input-group">'+
	              
	              '<span class="input-group-addon"><button type="button" class="btn btn-danger btn-xs quitarProducto" idProducto><i class="fa fa-times"></i></button></span>'+

	              '<select class="form-control nuevaDescripcionProducto" id="producto'+numProducto+'" idProducto name="nuevaDescripcionProducto" required>'+

	              '<option>Seleccione el producto</option>'+

	              '</select>'+  

	            '</div>'+

	          '</div>'+

	          '<!-- Cantidad del producto -->'+

	          '<div class="col-xs-3 ingresoCantidad">'+
	            
	             '<input type="number" class="form-control nuevaCantidadProducto" name="nuevaCantidadProducto" min="1" value="1" stock nuevoStock required>'+

	          '</div>' +

	          '<!-- Precio del producto -->'+

	          '<div class="col-xs-3 ingresoPrecio" style="padding-left:0px">'+

	            '<div class="input-group">'+

	              '<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>'+
	                 
	              '<input type="text" class="form-control nuevoPrecioProducto" precioReal="" name="nuevoPrecioProducto" readonly required>'+
	 
	            '</div>'+
	             
	          '</div>'+

	        '</div>');


	        // AGREGAR LOS PRODUCTOS AL SELECT 

	         respuesta.forEach(funcionForEach);

	         function funcionForEach(item, index){

	         	if(item.stock != 0){

		         	$("#producto"+numProducto).append(

						'<option idProducto="'+item.id+'" value="'+item.descripcion+'">'+item.descripcion+'</option>'
		         	)

		         }

	         }

	         // SUMAR TOTAL DE PRECIOS

    		sumarTotalPrecios()

    		// AGREGAR IMPUESTO
	        
	        agregarImpuesto()

	        // PONER FORMATO AL PRECIO DE LOS PRODUCTOS

	        $(".nuevoPrecioProducto").number(true, 2);

      	}


	})

})

/*=============================================
SELECCIONAR PRODUCTO
=============================================*/

$(".formularioVenta").on("change", "select.nuevaDescripcionProducto", function(){

	var nombreProducto = $(this).val();

	var nuevaDescripcionProducto = $(this).parent().parent().parent().children().children().children(".nuevaDescripcionProducto");

	var nuevoPrecioProducto = $(this).parent().parent().parent().children(".ingresoPrecio").children().children(".nuevoPrecioProducto");

	var nuevaCantidadProducto = $(this).parent().parent().parent().children(".ingresoCantidad").children(".nuevaCantidadProducto");

	var datos = new FormData();
    datos.append("nombreProducto", nombreProducto);


	  $.ajax({

     	url:"ajax/productos.ajax.php",
      	method: "POST",
      	data: datos,
      	cache: false,
      	contentType: false,
      	processData: false,
      	dataType:"json",
      	success:function(respuesta){
      	    
      	     $(nuevaDescripcionProducto).attr("idProducto", respuesta["id"]);
      	    $(nuevaCantidadProducto).attr("stock", respuesta["stock"]);
      	    $(nuevaCantidadProducto).attr("nuevoStock", Number(respuesta["stock"])-1);
      	    $(nuevoPrecioProducto).val(respuesta["precio_venta"]);
      	    $(nuevoPrecioProducto).attr("precioReal", respuesta["precio_venta"]);

  	      // AGRUPAR PRODUCTOS EN FORMATO JSON

	        listarProductos()

      	}

      })
})

/*=============================================
MODIFICAR LA CANTIDAD
=============================================*/

$(".formularioVenta").on("change", "input.nuevaCantidadProducto", function(){

	var precio = $(this).parent().parent().children(".ingresoPrecio").children().children(".nuevoPrecioProducto");

	var precioFinal = $(this).val() * precio.attr("precioReal");
	
	precio.val(precioFinal);

	var nuevoStock = Number($(this).attr("stock")) - $(this).val();

	$(this).attr("nuevoStock", nuevoStock);

	if(Number($(this).val()) > Number($(this).attr("stock"))){

		/*=============================================
		SI LA CANTIDAD ES SUPERIOR AL STOCK REGRESAR VALORES INICIALES
		=============================================*/

		$(this).val(1);

		var precioFinal = $(this).val() * precio.attr("precioReal");

		precio.val(precioFinal);

		sumarTotalPrecios();

		swal({
	      title: "La cantidad supera el Stock",
	      text: "¡Sólo hay "+$(this).attr("stock")+" unidades!",
	      type: "error",
	      confirmButtonText: "¡Cerrar!"
	    });

	    return;

	}

	// SUMAR TOTAL DE PRECIOS

	sumarTotalPrecios()

	// AGREGAR IMPUESTO
	        
    agregarImpuesto()

    // AGRUPAR PRODUCTOS EN FORMATO JSON

    listarProductos()

})

/*=============================================
SUMAR TODOS LOS PRECIOS
=============================================*/

function sumarTotalPrecios(){

	var precioItem = $(".nuevoPrecioProducto");
	var arraySumaPrecio = [];  

	for(var i = 0; i < precioItem.length; i++){

		 arraySumaPrecio.push(Number($(precioItem[i]).val()));
		 
	}

	function sumaArrayPrecios(total, numero){

		return total + numero;

	}

	var sumaTotalPrecio = arraySumaPrecio.reduce(sumaArrayPrecios);
	
	$("#nuevoTotalVenta").val(sumaTotalPrecio);
	$("#totalVenta").val(sumaTotalPrecio);
	$("#nuevoTotalVenta").attr("total",sumaTotalPrecio);


}

/*=============================================
FUNCIÓN AGREGAR IMPUESTO
=============================================*/

function agregarImpuesto(){

	var impuesto = $("#nuevoImpuestoVenta").val();
	var precioTotal = $("#nuevoTotalVenta").attr("total");

	var precioImpuesto = Number(precioTotal * impuesto/100);

	var totalConImpuesto = Number(precioImpuesto) + Number(precioTotal);
	
	$("#nuevoTotalVenta").val(totalConImpuesto);

	$("#totalVenta").val(totalConImpuesto);

	$("#nuevoPrecioImpuesto").val(precioImpuesto);

	$("#nuevoPrecioNeto").val(precioTotal);

}

/*=============================================
CUANDO CAMBIA EL IMPUESTO
=============================================*/

$("#nuevoImpuestoVenta").change(function(){

	agregarImpuesto();

});

/*=============================================
FORMATO AL PRECIO FINAL
=============================================*/

$("#nuevoTotalVenta").number(true, 2);

/*=============================================
SELECCIONAR MÉTODO DE PAGO
=============================================*/

function recalcular_inputs_meses() {
	var total_meses = parseFloat($(".totales.mes-" + sessionStorage.cantidad_meses_elegidos).html());
	var monto_pago_inicial = parseFloat($("#monto_pago_inicial").val());
	if (!monto_pago_inicial) {
		$("#monto_pago_inicial").val(0).number(true, 2);
	}
	
	// (cantidad de pagos por mes)
	var frecuencia_pagos_valores = {
		"mensual": 1,
		"quincenal": 2,
		"semanal": 4
	};
	var frecuencia_pagos = $("#frecuencia_pagos").val();
	var cantidad_pagos_mes = frecuencia_pagos_valores[frecuencia_pagos];
	var cantidad_pagos = cantidad_pagos_mes * sessionStorage.cantidad_meses_elegidos;
	$("#cantidad_pagos").html(cantidad_pagos);
	$("#cantidad_pagos_input").val(cantidad_pagos);

	var restante = total_meses - monto_pago_inicial;
	// var monto_cada_pago = restante / sessionStorage.cantidad_meses_elegidos;
	var monto_cada_pago = restante / cantidad_pagos;
	$("#monto_cada_pago").val(monto_cada_pago).number(true, 2);
	$("#monto_financiado").val(restante).number(true, 2);
	console.log("CALCULADO");
}

$("#detalle_meses").on("click", ".mes-1, .mes-2, .mes-3, .mes-4, .mes-5", function() {
	var element = $(this);
	var las_clases = ["mes-1", "mes-2", "mes-3", "mes-4", "mes-5"];
	var la_clase = "";
	$.each(las_clases, function(index, clase) {
		if (element.hasClass(clase)) {
			la_clase = clase;
			return false;
		}
	});
	
	sessionStorage.cantidad_meses_elegidos = la_clase.replace("mes-", "");
	$(".mes-1, .mes-2, .mes-3, .mes-4, .mes-5").removeClass("mes-elegido");
	$("." + la_clase).addClass("mes-elegido");

	recalcular_inputs_meses();
});

$("#frecuencia_pagos").on("change", function() {
	$("#nuevoMetodoPago").trigger("change");
});
$("#nuevoMetodoPago").change(function(){
	$(".cajasMetodoPago").html("");
	var metodo = $(this).val();
	if (metodo != "a_credito") {
		$("#detalle_meses").html("").hide();
		$("#frecuencia_pagos").hide();
	}
	if (metodo != "TC" && metodo != "TD") {
		$("#div_codigo_transaccion").hide();
	}

	if(metodo == "Efectivo") {
		/*
		$(this).parent().parent().removeClass("col-xs-6");
		$(this).parent().parent().addClass("col-xs-4");
		*/

		var htmlCajasMetodoPago1 = `
		<div class="col-xs-4">
		<div class="input-group"> 
							<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
							<input type="text" class="form-control" id="nuevoValorEfectivo" placeholder="000000" required style="background-color: #EFFFEA; color: blue">
						</div>
						 </td>
						 </div>
						 <div class="col-xs-4" id="capturarCambioEfectivo" style="padding-left:0px">
			 	<div class="input-group">
<table class="table">
<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>

			 		<input type="text" class="form-control" id="nuevoCambioEfectivo" placeholder="000000" readonly required style="background-color: #FF982D">

			 	</div>

			 </div>`

		var htmlCajasMetodoPago = ` 
			<div class="col-xs-4">
				Recibido:
				<div class="input-group"> 
					<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
					<input type="text" class="form-control" id="nuevoValorEfectivo" placeholder="0.00" required style="background-color: #EFFFEA; color: blue">
				</div>
			</div>
			<div class="col-xs-4" id="capturarCambioEfectivo" style="padding-left:0px">
				Cambio:
				<div class="input-group">
					<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
					<input type="text" class="form-control" id="nuevoCambioEfectivo" placeholder="0.00" readonly required style="background-color: #FF982D">
				</div>
			</div>
`;

		$(".cajasMetodoPago").html(htmlCajasMetodoPago)

		// Agregar formato al precio

		$('#nuevoValorEfectivo').number( true, 2);
      	$('#nuevoCambioEfectivo').number( true, 2);


      	// Listar método en la entrada
      	listarMetodos()

	}
	else if (metodo == "a_credito") {
		// A crédito
		$("#frecuencia_pagos").show();
		var frecuencia_pagos = $("#frecuencia_pagos").val();
		if (!frecuencia_pagos) {
			$("#detalle_meses").hide();
			return;
		}

		var _tbody = "";
		var totales = {
			1: 0,
			2: 0,
			3: 0,
			4: 0,
			5: 0
		};

		$(".nuevaDescripcionProducto").each(function(index) {
			var nombre_producto = $(this).val();
			var precios_meses = $(this).data("precios_meses");

			var id_producto = $(this).attr("idProducto");
			var cantidad = $("#nuevaCantidadProducto_" + id_producto).val();
			
			totales["1"] += (cantidad * parseFloat(precios_meses["1"]));
			totales["2"] += (cantidad * parseFloat(precios_meses["2"]));
			totales["3"] += (cantidad * parseFloat(precios_meses["3"]));
			totales["4"] += (cantidad * parseFloat(precios_meses["4"]));
			totales["5"] += (cantidad * parseFloat(precios_meses["5"]));
			
			var tr_class = index / 2 == 0 ? "odd" : "even";

			var mes1 = (cantidad * parseFloat(precios_meses["1"])).toFixed(2);
			var mes2 = (cantidad * parseFloat(precios_meses["2"])).toFixed(2);
			var mes3 = (cantidad * parseFloat(precios_meses["3"])).toFixed(2);
			var mes4 = (cantidad * parseFloat(precios_meses["4"])).toFixed(2);
			var mes5 = (cantidad * parseFloat(precios_meses["5"])).toFixed(2);

			_tbody += `
				<tr class="${tr_class} extra-meses-1">
					<td>${nombre_producto}</td>
					<td class="mes mes-1">${mes1}</td>
					<td class="mes mes-2">${mes2}</td>
					<td class="mes mes-3">${mes3}</td>
					<td class="mes mes-4">${mes4}</td>
					<td class="mes mes-5">${mes5}</td>
				</tr>`;
			
		});
		var htmlCajasMetodoPago = `
			<div>
				<div style="margin-bottom: 8px;">
					<button type="button" class="btn btn-sm btn-success" id="btn_detalles_meses">Detalle</button>
				</div>
				<table id="tabla_meses" class="table table-bordered table-striped">
					<thead>
						<tr>
							<th class="extra-meses-1">Producto</th>
							<th class="mes mes-1">1 Mes</th>
							<th class="mes mes-2">2 Meses</th>
							<th class="mes mes-3">3 Meses</th>
							<th class="mes mes-4">4 Meses</th>
							<th class="mes mes-5">5 Meses</th>
						</tr>
					</thead>
					<tbody>
						${_tbody}
					</tbody>
					<tfoot>
						<tr style="font-weight:bold;">
							<td class="extra-meses-1">TOTAL</td>
							<td class="totales mes mes-1">${totales["1"].toFixed(2)}</td>
							<td class="totales mes mes-2">${totales["2"].toFixed(2)}</td>
							<td class="totales mes mes-3">${totales["3"].toFixed(2)}</td>
							<td class="totales mes mes-4">${totales["4"].toFixed(2)}</td>
							<td class="totales mes mes-5">${totales["5"].toFixed(2)}</td>
						</tr>
					</tfoot>
				</table>
				<div class="form-group row">
					<div class="col-xs-4 pull-left">
						Cada pago (<span id="cantidad_pagos" name="cantidad_pagos"></span> pagos):
						<input type="hidden" name="cantidad_pagos" id="cantidad_pagos_input"/>
						<div class="input-group"> 
							<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
							<input type="text" class="form-control" id="monto_cada_pago" name="monto_cada_pago" placeholder="0.00" readonly required style="background-color: #EBFAFF">
						</div>
					</div>
					<div class="col-xs-4 pull-left">
						Monto financiado:
						<div class="input-group"> 
							<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
							<input type="text" class="form-control" id="monto_financiado" name="monto_financiado" placeholder="0.00" readonly required style="background-color: #FFECAD">
						</div>
					</div>
					<div class="col-xs-4 pull-left">
						Fecha primer pago:
						<div class="input-group"> 
							<span class="input-group-addon"><i class="ion ion-calendar"></i></span>
							<input type="text" class="form-control" id="fecha_primer_pago" name="fecha_primer_pago" placeholder="Fecha">
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-xs-12 pull-left">
						<select class="form-control" id="metodo_pago_inicial" name="metodo_pago_inicial" required>
							<option value="sin_pago_inicial">Sin pago inicial</option>
							<option value="efectivo">Pago inicial en efectivo</option>
							<option value="tarjeta_credito">Pago inicial con tarjeta de crédito</option>
							<option value="tarjeta_debito">Pago inicial con tarjeta de débito</option>
						</select>
					</div>
				</div>
				<div class="form-group row" style="display:none;" id="div_pago_inicial">
					<div class="col-xs-4 pull-left">
						Pago inicial:
						<div class="input-group"> 
							<span class="input-group-addon"><i class="ion ion-social-usd"></i></span>
							<input type="text" class="form-control" id="monto_pago_inicial" name="monto_pago_inicial" placeholder="0.00" required style="background-color: #EFFFEA; color: blue">
						</div>
					</div>
					<div class="col-xs-8 pull-left" id="div_codigo_transaccion">
						Código de transacción:
						<div class="input-group"> 
							<span class="input-group-addon"><i class="fa fa-lock"></i></span>
							<input type="text" class="form-control" id="codigo_transaccion" name="codigo_transaccion" placeholder="Código de transacción" style="background-color: #EBFAFF;">
						</div>
					</div>
				</div>
			</div>
		`;
		$("#detalle_meses").html(htmlCajasMetodoPago).show();
		$("#monto_pago_inicial").number(true, 2);

		$("#btn_detalles_meses").on("click", function() {
			$(".extra-meses-1").toggle();
			console.log("Cambiado");
		});

		$("#fecha_primer_pago").datepicker({
			format: "dd/mm/yyyy",
			language: "es",
			autoclose: true,
			todayHighlight: true,
			startDate: "0d"
		});
		
		actualizar_fecha_primer_pago();
		
		if (typeof sessionStorage.cantidad_meses_elegidos == "undefined") {
			$("#detalle_meses .mes-1").trigger("click");
		}
		else {
			$("#detalle_meses .mes-" + sessionStorage.cantidad_meses_elegidos).trigger("click");
		}

		$("#metodo_pago_inicial").on("change", function() {
			var metodo_pago_inicial = $(this).val();
			if (metodo_pago_inicial != "sin_pago_inicial") {
				$("#div_pago_inicial").show();
				if (metodo_pago_inicial == "tarjeta_credito" || metodo_pago_inicial == "tarjeta_debito") {
					$("#div_codigo_transaccion").show();
				}
				else {
					$("#div_codigo_transaccion").hide();
				}
			}
			else {
				$("#div_pago_inicial").hide();
			}
		});

		$("#monto_pago_inicial").on("change, keyup", recalcular_inputs_meses);
		listarMetodos();
	}
	else if (metodo == "TC" || metodo == "TD"){
		/*
		$(this).parent().parent().removeClass('col-xs-4');
		$(this).parent().parent().addClass('col-xs-6');
		*/
		 $('.cajasMetodoPago').html(
			 `
			 	<div class="col-xs-8" id="div_codigo_transaccion">
					<div class="input-group">
						<input type="number" min="0" class="form-control" id="nuevoCodigoTransaccion" placeholder="Código transacción"  required>
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
					</div>
				</div>
			`);

	}

	

});

function actualizar_fecha_primer_pago() {
	var frecuencia_pagos = $("#frecuencia_pagos").val();
	var fecha_primer_pago = "";
	if (frecuencia_pagos == "semanal") {
		fecha_primer_pago = "+7d";
	}
	else if (frecuencia_pagos == "quincenal") {
		fecha_primer_pago = "+14d";
	}
	else if (frecuencia_pagos == "mensual") {
		fecha_primer_pago = "+28d";
	}
	$("#fecha_primer_pago").datepicker("update", fecha_primer_pago);
}

/*=============================================
CAMBIO EN EFECTIVO
=============================================*/
$(".formularioVenta").on("change", "input#nuevoValorEfectivo", function(){

	var efectivo = $(this).val();

	var cambio =  Number(efectivo) - Number($('#nuevoTotalVenta').val());

	var nuevoCambioEfectivo = $(this).parent().parent().parent().children('#capturarCambioEfectivo').children().children('#nuevoCambioEfectivo');

	nuevoCambioEfectivo.val(cambio);

})

/*=============================================
CAMBIO TRANSACCIÓN
=============================================*/
$(".formularioVenta").on("change", "input#nuevoCodigoTransaccion", function(){

	// Listar método en la entrada
     listarMetodos()


})


/*=============================================
LISTAR TODOS LOS PRODUCTOS
=============================================*/

function listarProductos(){

	var listaProductos = [];

	var descripcion = $(".nuevaDescripcionProducto");

	var cantidad = $(".nuevaCantidadProducto");

	var precio = $(".nuevoPrecioProducto");

	for(var i = 0; i < descripcion.length; i++){

		listaProductos.push({ "id" : $(descripcion[i]).attr("idProducto"), 
							  "descripcion" : $(descripcion[i]).val(),
							  "cantidad" : $(cantidad[i]).val(),
							  "stock" : $(cantidad[i]).attr("nuevoStock"),
							  "precio" : $(precio[i]).attr("precioReal"),
							  "total" : $(precio[i]).val()})

	}

	$("#listaProductos").val(JSON.stringify(listaProductos)); 

}

/*=============================================
LISTAR MÉTODO DE PAGO
=============================================*/

function listarMetodos(){

	var listaMetodos = "";

	if($("#nuevoMetodoPago").val() == "Efectivo"){

		$("#listaMetodoPago").val("Efectivo");

	} else if ($("#nuevoMetodoPago").val() == "a_credito") {

		$("#listaMetodoPago").val("a_credito");

	}else{

		$("#listaMetodoPago").val($("#nuevoMetodoPago").val()+"-"+$("#nuevoCodigoTransaccion").val());

	}

}

/*=============================================
BOTON EDITAR VENTA
=============================================*/
$(".tablas").on("click", ".btnEditarVenta", function(){

	var idVenta = $(this).attr("idVenta");

	window.location = "index.php?ruta=editar-venta&idVenta="+idVenta;


})

/*=============================================
FUNCIÓN PARA DESACTIVAR LOS BOTONES AGREGAR CUANDO EL PRODUCTO YA HABÍA SIDO SELECCIONADO EN LA CARPETA
=============================================*/

function quitarAgregarProducto(){

	//Capturamos todos los id de productos que fueron elegidos en la venta
	var idProductos = $(".quitarProducto");

	//Capturamos todos los botones de agregar que aparecen en la tabla
	var botonesTabla = $(".tablaVentas tbody button.agregarProducto");

	//Recorremos en un ciclo para obtener los diferentes idProductos que fueron agregados a la venta
	for(var i = 0; i < idProductos.length; i++){

		//Capturamos los Id de los productos agregados a la venta
		var boton = $(idProductos[i]).attr("idProducto");
		
		//Hacemos un recorrido por la tabla que aparece para desactivar los botones de agregar
		for(var j = 0; j < botonesTabla.length; j ++){

			if($(botonesTabla[j]).attr("idProducto") == boton){

				$(botonesTabla[j]).removeClass("btn-primary agregarProducto");
				$(botonesTabla[j]).addClass("btn-default");

			}
		}

	}
	
}

/*=============================================
CADA VEZ QUE CARGUE LA TABLA CUANDO NAVEGAMOS EN ELLA EJECUTAR LA FUNCIÓN:
=============================================*/

$('.tablaVentas').on( 'draw.dt', function(){

	quitarAgregarProducto();

})



/*=============================================
BORRAR VENTA
=============================================*/
$(".tablas").on("click", ".btnEliminarVenta", function(){

  var idVenta = $(this).attr("idVenta");

  swal({
        title: '¿Está seguro de borrar la venta?',
        text: "¡Si no lo está puede cancelar la accíón!",
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Si, borrar venta!'
      }).then(function(result){
        if (result.value) {
          
            window.location = "index.php?ruta=ventas&idVenta="+idVenta;
        }

  })

})

/*=============================================
IMPRIMIR FACTURA
=============================================*/

$(".tablas").on("click", ".btnImprimirFactura", function(){

	var codigoVenta = $(this).attr("codigoVenta");

	window.open("extensiones/tcpdf/pdf/factura.php?codigo="+codigoVenta, "_blank");

})

/*=============================================
RANGO DE FECHAS
=============================================*/

$('#daterange-btn').daterangepicker(
  {
    ranges   : {
      'Hoy'       : [moment(), moment()],
      'Ayer'   : [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
      'Últimos 7 días' : [moment().subtract(6, 'days'), moment()],
      'Últimos 30 días': [moment().subtract(29, 'days'), moment()],
      'Este mes'  : [moment().startOf('month'), moment().endOf('month')],
      'Último mes'  : [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
    },
    startDate: moment(),
    endDate  : moment()
  },
  function (start, end) {
    $('#daterange-btn span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));

    var fechaInicial = start.format('YYYY-MM-DD');

    var fechaFinal = end.format('YYYY-MM-DD');

    var capturarRango = $("#daterange-btn span").html();
   
   	localStorage.setItem("capturarRango", capturarRango);

   	window.location = "index.php?ruta=ventas&fechaInicial="+fechaInicial+"&fechaFinal="+fechaFinal;

  }

)

/*=============================================
CANCELAR RANGO DE FECHAS
=============================================*/

$(".daterangepicker.opensleft .range_inputs .cancelBtn").on("click", function(){

	localStorage.removeItem("capturarRango");
	localStorage.clear();
	window.location = "ventas";
})

/*=============================================
CAPTURAR HOY
=============================================*/

$(".daterangepicker.opensleft .ranges li").on("click", function(){

	var textoHoy = $(this).attr("data-range-key");

	if(textoHoy == "Hoy"){

		var d = new Date();
		
		var dia = d.getDate();
		var mes = d.getMonth()+1;
		var año = d.getFullYear();

		if(mes < 10){

			var fechaInicial = año+"-0"+mes+"-"+dia;
			var fechaFinal = año+"-0"+mes+"-"+dia;

		}else if(dia < 10){

			var fechaInicial = año+"-"+mes+"-0"+dia;
			var fechaFinal = año+"-"+mes+"-0"+dia;

		}else if(mes < 10 && dia < 10){

			var fechaInicial = año+"-0"+mes+"-0"+dia;
			var fechaFinal = año+"-0"+mes+"-0"+dia;

		}else{

			var fechaInicial = año+"-"+mes+"-"+dia;
	    	var fechaFinal = año+"-"+mes+"-"+dia;

		}	

    	localStorage.setItem("capturarRango", "Hoy");

    	window.location = "index.php?ruta=ventas&fechaInicial="+fechaInicial+"&fechaFinal="+fechaFinal;

	}

})




