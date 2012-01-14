// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function(){
  
  // register onClick hook
  //
  $(".day").click( function(){ return false; } );
  $(".clickable").click( function(){ 
    new Day( $(this) ).mark();
    return false;
  });


  // creates bubble popup for holidays
  //
  $('.holiday').each( function(i){
    $(this).CreateBubblePopup({ 
      innerHtml: $(this).attr('title'),
      selectable: true,
      themeName: 'all-black',
      themePath: '/images/jquerybubblepopup-theme'
    });
  });

  $("#wysuwany_div").mouseover(function() {
    $("#wysuwany_div").stop();
    $("#wysuwany_div").animate({ right: "0" },350 );
  });
        
  $("#wysuwany_div").mouseout(function() {
    $("#wysuwany_div").stop();
    $("#wysuwany_div").animate({ right: "-209" }, 350 );
  });

  //Tabs
  //When page loads...
  $(".tab_content").hide(); //Hide all content
  $("ul.tabs li:first").addClass("active").show(); //Activate first tab
  $(".tab_content:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs li").click(function() {

    $("ul.tabs li").removeClass("active"); //Remove any "active" class
    $(this).addClass("active"); //Add "active" class to selected tab
    $(".tab_content").hide(); //Hide all tab content

    var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active ID content
    return false;
  });
  
} );



function markPeriod( d, join_periods ) {
  var day = new Day( d );
  var period_id = newPeriodId();

  if( join_periods ) $.each( [day.next(), day.prev()], function(i,d){ if( d.getPeriodId() ){ period_id = d.getPeriodId(); } } );
  
  day.markAsPeriod( period_id );
  
  var nxt = day.next();
  var prev = day.prev();
  while( nxt.isFree() || nxt.isPeriod() || nxt.isLeave() ) {
    nxt.markAsPeriod( period_id );
    nxt = nxt.next();
  }  
  while( prev.isFree() || prev.isPeriod() || prev.isLeave() ) {
    prev.markAsPeriod( period_id );
    prev = prev.prev();
  } 
  printPeriods();
}

function unmarkPeriod(d) {
  var day = new Day( d );
  var period_id = day.getPeriodId();
  var new_periods_to_mark = new Array();
  day.unmarkAsPeriod();

  var nxt = day.next();
  var period_to_unmark = new Array();
  while( nxt.isPeriod() ) {
    if( nxt.isLeave() ){
      new_periods_to_mark.push( nxt );
      period_to_unmark = new Array();
      break;
    }
    period_to_unmark.push( nxt );
    nxt = nxt.next();
  } 
  $.each( period_to_unmark, function(i,d){
    d.unmarkAsPeriod();
  } );
  
  var prev = day.prev();
  period_to_unmark = new Array();
  while( prev.isPeriod() ) {
    if( prev.isLeave() ){
      new_periods_to_mark.push( prev );
      period_to_unmark = new Array();
      break;
    }
    period_to_unmark.push( prev );
    prev = prev.prev();
  }
  $.each( period_to_unmark, function(i,d){
    d.unmarkAsPeriod();
  } );

  $.each( new_periods_to_mark, function(i,d){ markPeriod( d.element, false ) });
  printPeriods();
} 


function updateLeaveCounter() {
  $("#leave-count").text( $(".leave").length );
  $("#period-count").text( $(".period").length );
}

function toggleIntMenu( menu ) {
  if( $("div#"+menu+"-choose").css('display') != 'block' ){
    $(".int-menu").hide();
    $(".int-menu-link").removeClass('current-int-menu');
    showIntMenu( menu );
  }else {
    hideIntMenu( menu );
  }
}

function showIntMenu( menu ) {
  $("#"+menu).addClass('current-int-menu');
  $("div#"+menu+"-choose").show();
}

function hideIntMenu( menu ) {
  $("#"+menu).removeClass('current-int-menu');
  $("div#"+menu+"-choose").hide();
}

function getMarkedDaysIds(){ return $.map( $('.leave'), function(d,i){ return $(d).attr('id') } ); }

function storeMarkedDays( year ){
  $.jStorage.set( "holidayplanner_"+year, getMarkedDaysIds() );
}

function getStoredDaysIds( year ){ return $.jStorage.get( "holidayplanner_"+year ); }

function markStoredDays( year ){
  leave = getStoredDaysIds( year );
  if( leave ){
    $.each( leave, function(k,d){ new Day($( '#'+d )).markUp() } );
  }
}

function newPeriodId(){ return (new Date).getTime(); }

function getPeriods(){
  var periods = new Hashtable();
  var period_days = $("a.day.period");
  if( period_days ){
    $.each( period_days, function(i,d){
      var day = new Day( $(d) );
      var period_id = day.getPeriodId();
      if( periods.containsKey( period_id ) ){
        p = periods.get( period_id );
        p.days.push( day );
        periods.put( period_id, p );
      }else {
        periods.put( period_id, new LeavePeriod( [day] ) );
      }
    });
  }
  return periods;
}

function printPeriods(){
  $("#periords-list").html("");
  getPeriods().each( function(k,period){
    period.print();
  });
}