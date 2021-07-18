$(document).ready(function(){

  var basabilir = false
  var secilikeybind = null
var keyCodes = {
    178: 'Delete',
    192: 'Tab',
    137: 'CapsLock',
    200: 'Escape',
    208: 'PageUp',
    207: 'PageDown',
    212: 'Home',
    174: 'ArrowLeft',
    172: 'ArrowUp',
    175: 'ArrowRight',
    173: 'ArrowDown',
    121: 'Insert',
    34: 'KeyA',
    29: 'KeyB',
    26: 'KeyC',
    30: 'KeyD',
    46: 'KeyE',
    23: 'KeyF',
    113: 'KeyG',
    304: 'KeyH',
    311: 'KeyK',
    182: 'KeyL',
    244: 'KeyM',
    249: 'KeyN',
    199: 'KeyP',
    44: 'KeyQ',
    45: 'KeyR',
    245: 'KeyT',
    303: 'KeyU',
    320: 'KeyV',
    105: 'KeyX',
    246: 'KeyY',
    20: 'KeyZ',
    108: 'Numpad4',
    110: 'Numpad5',
    109: 'Numpad6',
    117: 'Numpad7',
    111: 'Numpad8',
    118: 'Numpad9',
    288: 'F1',
    289: 'F2',
    170: 'F3',
    166: 'F5',
    167: 'F6',
    168: 'F7',
    169: 'F8',
    56: 'F9',
    57: 'F10',
    344: 'F11',
  };


  window.addEventListener('message', function(event) {
    var item = event.data;
    if(item.type === "ui") {
      if (item.status) {
        $(".panel").fadeIn();
      }
      else {
        $(".panel").fadeOut();
      }
    }
    else if(item.type === "UISetup") {
      $.each(item.bindings, function( index, value ) {
        var anlik = $("#number" + (parseInt(index)).toString());
        anlik.children().first().text(keyCodes[value["tus"]])
        anlik.children().first().next().val(value["komut"])
        anlik.children().first().next().next().val(value["arguman"])
      });
    }
  })

  $( ".fa-times" ).on( "click", function() {
      $.post('http://wiro_commandbinding/exit', JSON.stringify({}));
  });

  $( ".short-key" ).on( "click", function() {
      $("#komutbekle").show();
      secilikeybind = $(this);
      basabilir = true;
  });

  $( ".bottomdiv" ).on( "click", function() {
    var save = {}
    var stri = "1"
    for (let i = 1; i <= 5; i++) {
      stri = i.toString();
      if ($("#key" + stri).text() != "boş") {
        save[stri] = { tus: parseInt(getKeyByValue(keyCodes, $("#key" + stri).text())), komut: $("#komut" + stri).val(), arguman: $("#arguman" + stri).val()}
      }
      else {
        save[stri] = { tus: "boş", komut: $("#komut" + stri).val(), arguman: $("#arguman" + stri).val()}
      }
    }

    $.post('http://wiro_commandbinding/save', JSON.stringify({
      savetable: save
  }));

  $.post('http://wiro_commandbinding/exit', JSON.stringify({}));

  });
  
  $("body").keydown(function(event){
    if (basabilir & secilikeybind != null) {
      if (getKeyByValue(keyCodes, event.code) != undefined && event.code != "Space") {
        secilikeybind.text(event.code)
        basabilir = false
        secilikeybind = null
        $("#komutbekle").hide();
      }
      if (event.code == "Space") {
        secilikeybind.text("boş")
        basabilir = false
        secilikeybind = null
        $("#komutbekle").hide();
      }
    }
  });
  
  function getKeyByValue(obj, value) {
    return Object.keys(obj).find(key => obj[key] === value);
  }
});