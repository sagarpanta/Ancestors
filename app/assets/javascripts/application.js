// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//	
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

	$("#org").jOrgChart({
		chartElement : '#chart',
		dragAndDrop  : false
    });
	
	
	var window_width = $(window).width();
	var window_height = $(window).height();
	
	var table_height = $('table#_content').css('height');	
	console.log(window_width);
	console.log(window_height);
	$('.jOrgChart').css('height', parseInt(window_height) - 150);


	
	$("ul.menu li").mouseover(function() {
		$(this).css("background", "#bbb");
	});
	
	$("ul.menu li").mouseout(function() {
		$(this).css("background", "#eee");
	});
	

	$("ul#navlist  li").mouseover(function() {
		$(this).css("background", "#444");
	});
	
	$("ul#navlist  li").mouseout(function() {
		$(this).css("background", "#222");
	});
	
	$("#sidebar ul li").mouseover(function() {
		$(this).css("background", "#aaa");

	});
	
	$("#sidebar ul li").mouseout(function() {
		$(this).css("background", "#222");
	});
	
	$("#org ul li").mouseover(function() {
		$(this).css("background", "#aaa");
	});
	
	$("#sidebar li").click(function() {
		//$("#chart").hide();
		//var name = $(this).html();
		var imgSrc = $(this).children('#hiddenImg').children('span').children('a').html();
		var imgTag = '<img src='+imgSrc+ '/>';
		
		console.log(imgTag);
		var page = $(this).children('#hiddenshowchild').html();
		$.ajax({
			url: page,
			type: 'get',
			dataType: 'json',
			cache: false,
			success: function(data) {
				$('#chart').html('');
				$('#orgColumn').children('ul').html(data['x']);
				$("#org").jOrgChart({
					chartElement : '#chart',
					dragAndDrop  : false
				});
				var table_height = $('table#_content').css('height');	

				$('.jOrgChart').css('height', parseInt(window_height) - 150);
				
				var ht = parseInt(window_height)-100;
				$('.jOrgChart').children('table').children('tbody').prepend('<tr><td colspan="4"><img src='+data['y']+'</td></tr>');
				
				$('#prependedTable').remove();
				
				var _html = '<table id="prependedTable" style="position:relative; float:right; width:30%; background-color:#aaa; color:black; border:2px solid white; min-height:'+ht+'px !important"><tr><td style="left:10px;box-sizing:border-box;border:10px solid transparent; font-style:italic" valign="top"><div style="font-weight:bold">About: </div>'+data['z']+'</td></tr></table>';
				$('#orgColumn').prepend(_html);
			
			},
			error: function(jqXHR, textStatus, errorThrown){ 
					console.log(errorThrown);
			}
			
			/*
			var content = $(data).find('table').html()
				$('#chart').hide();
				$('#profile').html(content).show();
			}
			*/
		});
		
		
	});
	
	
	$(":submit").click(function() {
		var searchname = $("#name").val().toUpperCase();
		$(".node").css("background", "#222").css("color", "#fff");
		if (searchname == '') {
			$(".node:contains('"+ searchname+ "')").css("background", "#222") ;
		}
		else {
			$(".node:contains('"+ searchname+ "')").css("background", "#FFCC00").css("color", "black");
		}
		nodeTop = $(".node:contains('"+ searchname+ "')").position().top;
		nodeLeft = $(".node:contains('"+ searchname+ "')").position().left;
		scrollAmountTop =  nodeTop - (nodeTop+$(window).height())/4;
		scrollAmountLeft = nodeLeft - (nodeLeft+$(window).width())/4;
	
		$('#chart').animate({scrollTop:  scrollAmountTop},1000).animate({scrollLeft: scrollAmountLeft},1000);
	});
	
	$("#searchCancelButton").click(function() {
		$(".node").css("background", "#FFCC00").css("color", "black");
		$('input#name').val('');
	});
	
	
	
	
	$("#navlist li").click(function() {
		var initial = $(this).html();
		var name;
		$("#sidebar ul li").show();
		$("#sidebar ul li").each(function() {		
			var  name = $(this).html();
			if (name[0] != initial && initial != 'ALL' ) {
				$(this).hide();
			}
			
		});
	});
});

