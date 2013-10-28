
      $(document).ready(function() {
        var keys = [];
        var code = [38, 38, 40, 40, 37, 39, 37, 39, 66, 65, 13];
        var keys1=[];
        var code1 = [27];
        /*var keys2=[];
        var code2 = [74,79,66,76,65,78,68]*/
        $("#shh").hide();
        $(document).keydown(function(keyEvent) {
          keys.push(keyEvent.keyCode);
          keys1.push(keyEvent.keyCode);
          /*keys2.push(keyEvent.keyCode);*/
          if ( keys.length > code.length ) {
            keys.shift();
          }
          if ( keys1.length > code1.length ) {
            keys1.shift();
          }/*
          if ( keys2.length > code2.length ) {
            keys2.shift();
          }*/
          if ( keys.toString() == code.toString() ) {
            $('#shh').slideDown('slow');
          }
          if ( keys1.toString() == code1.toString() ) {
               $(document).ready()
               }/*
          if ( keys2.toString() == code2.toString() ) {
            $(window.open("//www.youtube.com/embed/KT4vhl8slbE?autoplay=1"));
          }*/
        });
      });
