// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready( function(){

  $('a.x-year-change-plus').click(function(){
    changeYear( getYear() + 1 );
    return false;
  });

  $('a.x-year-change-minus').click(function(){
    changeYear( getYear() - 1 );
    return false;
  });

  $("a[rel*=leanModal]").leanModal({ overlay : 0.4, closeButton: ".modal_close" });

  $(window).scroll(function(e){ 
    $el = $('.top-wrapper'); 
    if( $(this).scrollTop() > 50 ){
      if( !$el.hasClass('fixed') ){ $el.addClass('fixed'); }
    }else{ $el.removeClass('fixed'); }
  });

  initTabs();
  initCalendar( getYear() );
} );

function changeYear( year ){ 
  $.get('/planner/'+year, function(data) {
    swapCalendar(data, (year > getYear()) );
    initCalendar(year);
    setYear(year);
  });
  return false;
}

function swapCalendar( calendar, append ){
  var animation_duration = 500;
  $(".content-main > .calendar-section .calendar-element").addClass("section-swap"); 
  if( append ){
    $(".content-main > .calendar-section").append(calendar);
    activateCurrentTab();
    $('.section-swap').stop().animate({width:"0px"},animation_duration,function(){
      $(this).remove();
      updateLeaveCounter();
    });
  }else{
    var calendar = $(calendar);
    calendar.css('width','0px');
    $(".content-main > .calendar-section").prepend(calendar);
    activateCurrentTab();
    calendar.stop().animate({width:"1008px"},animation_duration,function(){
      $('.section-swap').remove();
      updateLeaveCounter();
    });
  }
  
   
}

function activateCurrentTab(){
  var active_tab_id = $("ul.tabs li.active a").attr('href');
  $(active_tab_id+".tab_content", ".content-main > .calendar-section .calendar-element:not(.section-swap)").show();
}

function getYear(){ return parseInt( $(".x-year").html() ); }

function setYear( year ){ $(".x-year").html(year); }

function initCalendar( year ){
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

  markStoredDays( year );  
  updateLeaveCounter();
}

function initTabs(){
  //When page loads...
  //$(".tab_content").hide(); //Hide all content
  $("ul.tabs li:first").addClass("active"); //.show(); //Activate first tab
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
}

function saveDay(d) { return true; }
  
function deleteDay(d) { return true; }

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