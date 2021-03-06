# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready= ->
	$("#flowchart").ready ->
		flow_id = $("#flowchart").data("id")
		if flow_id?
			console.log flow_id
			$.ajax(
				type: 'GET'
				url: "/diagrams/#{flow_id}.json"
				dataType: 'json'
			).done (response) -> 
				$("#flowchart").append """
					<section class="elipse">
						<h2>Inicio</h2>
						<p class="hidden></p>
						<p class="hidden>Un &oacute;valo que representa el inicio del diagrama de flujo</p>
					</section>
				"""
				$.each response.items, (index, value) ->
					$("#flowchart").append """
						<section class="square">
						    <h2>#{value.text}</h2>
						    <p class="hidden" >#{value.description}</p>
						</section>

						"""
				$("#flowchart").append """
					<section class="elipse">
						<h2>Fin</h2>
						<p class="hidden">Un &oacute;valo que representa el fin del diagrama de flujo</p>
					</section>
				"""

				$("#flowchart section").click  ->
					texto = $(this).children("p").text()
					msg = new SpeechSynthesisUtterance(texto)
					msg.lang = 'es'
					window.speechSynthesis.speak(msg)

				$(".elipse").click  ->
					texto = $(this).children("p").text()
					msg = new SpeechSynthesisUtterance(texto)
					msg.lang = 'es'
					window.speechSynthesis.speak(msg)
				true
		else
			$.ajax(
				type: 'GET'
				url: "/diagrams.json"
				dataType: 'json'
			).done (response) ->
				$.each response, (index, value) ->
					color = 'white'
					color = 'gray' if (index%2 == 0) 
					$("#flowcharts").append """
						<div class="row">
							<div class="col-md-offset-3 col-md-6" style="height:350px;background-color:#{color};padding-top:80px;">
								<h1 class="text-center"><a href="/flowcharts/#{value.id}">#{value.name}</a></h1>
								<p class="text-center">#{value.description}</p>
							</div>
						</div>
					"""
					console.log value, typeof value
				$("#flowcharts h1, #flowcharts p").css("border", "3px solid black")
				$("#flowcharts h1, #flowcharts p").mouseleave ->
					texto = $(this).text()
					msg = new SpeechSynthesisUtterance(texto)
					msg.lang = 'es'
					window.speechSynthesis.speak(msg)
	true


$(document).ready(ready)
$(document).on('page:load', ready)
