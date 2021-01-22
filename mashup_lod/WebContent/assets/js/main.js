/*
	Theory by TEMPLATED
	templated.co @templatedco
	Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
*/

(function($) {

	// Breakpoints.
		skel.breakpoints({
			xlarge:	'(max-width: 1680px)',
			large:	'(max-width: 1280px)',
			medium:	'(max-width: 980px)',
			small:	'(max-width: 736px)',
			xsmall:	'(max-width: 480px)'
		});
		
		
		//All functions on window load 
		$(function() {

			var	$window = $(window),
			$body = $('body');

			// Disable animations/transitions until the page has loaded.
			$body.addClass('is-loading');

			$window.on('load', function() {
				window.setTimeout(function() {
					$body.removeClass('is-loading');
				}, 100);
			});

			// Prioritize "important" elements on medium.
			skel.on('+medium -medium', function() {
				$.prioritize(
					'.important\\28 medium\\29',
					skel.breakpoint('medium').active
				);
			});
			
			
			/*Added for customization of template*/
			
			//Function to retrieve the URL Parameters
			$.urlParam = function(name){
			    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
			    if (results==null){
			       return null;
			    }
			    else{
			       return decodeURI(results[1]) || 0;
			    }
			}


			//Function to display the Popup window for Detailed Specifications
			$('#demo').on('click', function( e ) 
			{
						
					 	$.fn.custombox( this, {
					        overlay: true,
					        effect: 'superscaled',
					        escKey: true,
					        overlayOpacity:0.5,
					        overlaySpeed: 300,
					        width: 900,
					        height: 600
					    });
						e.preventDefault();
			});
			
			//To display the news in index.html
			$.getJSON('https://newsapi.org/v2/top-headlines?q=web&apiKey=d6063f89165c49f7836335dea1d279a4', function(data){
				var text=`${data.articles[0].title}`;
				$("#title_one").html(text);
				var text=`${data.articles[0].description}`;
				$("#desc_one").html(text);
				var text=`${data.articles[1].title}`;
				$("#title_two").html(text);
				var text=`${data.articles[1].description}`;
				$("#desc_two").html(text);
				var text=`${data.articles[2].title}`;
				$("#title_three").html(text);
				var text=`${data.articles[2].description}`;
				$("#desc_three").html(text);
				var text=`${data.articles[0].url}`;
				$("#more_one").attr("href", text);
				var text=`${data.articles[1].url}`;
				$("#more_two").attr("href", text);
				var text=`${data.articles[2].url}`;
				$("#more_three").attr("href", text);

			});
			
			function showdetails(id)
			{
				alert("hi");
			}
			
			
			//To set the headings in brnd.html page
			var brand = $.urlParam('id');
			var brand = $.urlParam('name');
			//$("#headingleft").html(brand + " Smart Phones");
			
			//$("#headingright2").html(brand + " Phone Videos");
			
			//To display the location of stores in brand.html page
			$("#google_map").attr("src", "https://www.google.com/maps/embed/v1/search?key=AIzaSyDg2Z-2YI_n-y9J3jnFRhRwyLKOxGLb2Fo&q="+brand+"+store+in+Chennai&zoom=13")
			
			//To display the youtube review videos in brand.html page
			$("#ytplayer").attr("src", "https://www.youtube.com/embed?listType=search&list="+ brand +"+latest+phone+review")
			//alert(brand);
			
			//To retrieve and display all the smart phone models of a particular brand in brand.html page
			/*$.getJSON('https://fonoapi.freshpixl.com/v1/getlatest?token=b7b1c889e5b04ac53eba3792ae58853659197ee3746accac&brand=' + brand + '&device=' + brand, function(data){
				
				var i;
				for (i = 0; i < data.length; i++) {
					
					var tr = document.createElement("tr"); 
					$("#mobile_list tbody").append(tr);
					var td1 = "<td class='brand'></td>";
					var td2 = "<td class='launchyear'></td>"; 
					var td3 = "<td class='os'></td>"; 
					$("#mobile_list tbody tr:last").append(td1, td2, td3);
	
					var devicename=`${data[i].DeviceName}`;
					var launchyear = `${data[i].announced}`;
					var os = `${data[i].os}`;
					$("#mobile_list tbody tr:last td.brand").html("<a href=\"#\" class=\"link\">" + devicename + "</a>");
					$("#mobile_list tbody tr:last td.launchyear").html(launchyear);
					$("#mobile_list tbody tr:last td.os").html(os);

				} 
				
				//Associate the link to open the popup window for each of the model numbers link
				$(".link").click(function(){
					$("#demo").trigger( "click" );
					fillData($(this).html());
				})
			
			});*/
			
			/*//Fill details of the model in the pop up window for specifications
			function fillData(model)
			{
				$("#detailed_spec").html("Detailed Specifications for " + model);
				
				$.getJSON('https://fonoapi.freshpixl.com/v1/getdevice?token=b7b1c889e5b04ac53eba3792ae58853659197ee3746accac&&device=' + model, function(data){
					
					var i;
					for (i = 0; i < data.length; i++) {
						
						var devicename=`${data[i].DeviceName}`;
						if(devicename == model)
						{
							General
							$("td#modelname").html(devicename);
							var announced = `${data[i].announced}`;
							$("td#announced").html(announced);
							var status = `${data[i].status}`;
							$("td#status").html(status);
							var technology = `${data[i].technology}`;
							$("td#technology").html(technology);
							var gprs = `${data[i].gprs}`;
							$("td#gprs").html(gprs);
							var edge = `${data[i].edge}`;
							$("td#edge").html(edge);
							var battery_c = `${data[i].battery_c}`;
							$("td#battery_c").html(battery_c);
							
							
							Body
							var dimensions = `${data[i].dimensions}`;
							$("td#dimensions").html(dimensions);
							var weight = `${data[i].weight}`;
							$("td#weight").html(weight);
							var sim = `${data[i].sim}`;
							$("td#sim").html(sim);
							var card_slot = `${data[i].card_slot}`;
							$("td#card_slot").html(card_slot);
							
							Display
							var type = `${data[i].type}`;
							$("td#type").html(type);
							var size = `${data[i].size}`;
							$("td#size").html(size);
							var resolution = `${data[i].resolution}`;
							$("td#resolution").html(resolution);
							var multitouch = `${data[i].multitouch}`;
							$("td#multitouch").html(multitouch);
							var protection = `${data[i].protection}`;
							$("td#protection").html(protection);
							
							Platform
							var os = `${data[i].os}`;
							$("td#os").html(os);
							var chipset = `${data[i].chipset}`;
							$("td#chipset").html(chipset);
							var cpu = `${data[i].cpu}`;
							$("td#cpu").html(cpu);
							var gpu = `${data[i].gpu}`;
							$("td#gpu").html(gpu);
							var internal = `${data[i].internal}`;
							$("td#internal").html(internal);
							
							Camera
							var primary_ = `${data[i].primary_}`;
							$("td#primary_").html(primary_);
							var features_c = `${data[i].features_c}`;
							$("td#features_c").html(features_c);
							var video = `${data[i].video}`;
							$("td#video").html(video);
							var secondary = `${data[i].secondary}`;
							$("td#secondary").html(secondary);
							
							Sound
							var alert_types = `${data[i].alert_types}`;
							$("td#alert_types").html(alert_types);
							var loudspeaker_ = `${data[i].loudspeaker_}`;
							$("td#loudspeaker_").html(loudspeaker_);
							var _3_5mm_jack_ = `${data[i]._3_5mm_jack_}`;
							$("td#_3_5mm_jack_").html(_3_5mm_jack_);
							
							Communications
							var wlan = `${data[i].wlan}`;
							$("td#wlan").html(wlan);
							var bluetooth = `${data[i].bluetooth}`;
							$("td#bluetooth").html(bluetooth);
							var gps = `${data[i].gps}`;
							$("td#gps").html(gps);
							var nfc = `${data[i].nfc}`;
							$("td#nfc").html(nfc);
							var radio = `${data[i].radio}`;
							$("td#radio").html(radio);
							var usb = `${data[i].usb}`;
							$("td#usb").html(usb);
							
							Features
							var sensors = `${data[i].sensors}`;
							$("td#sensors").html(sensors);
							var messaging = `${data[i].messaging}`;
							$("td#messaging").html(messaging);
							var browser = `${data[i].browser}`;
							$("td#browser").html(browser);
							break;
						} //if loop				    
					} //for loop
					
					
					}); //getJSON
			} //function fillData
*/			
			/*Added for Customizatiion End*/

			
			
			// Off-Canvas Navigation.

			// Navigation Panel.
			$(
				'<div id="navPanel">' +
					$('#nav').html() +
					'<a href="#navPanel" class="close"></a>' +
				'</div>'
			)
				.appendTo($body)
				.panel({
					delay: 500,
					hideOnClick: true,
					hideOnSwipe: true,
					resetScroll: true,
					resetForms: true,
					side: 'left'
				});

			// Fix: Remove transitions on WP<10 (poor/buggy performance).
			if (skel.vars.os == 'wp' && skel.vars.osVersion < 10)
				$('#navPanel')
					.css('transition', 'none');

	});

})(jQuery);
