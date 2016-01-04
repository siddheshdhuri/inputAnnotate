
$(document).on("mouseup", "div.inputAnnotate", function() {
  var el = $(this);
  // Raise an event to signal that the value changed
  el.trigger("change");
});
//$(document).on("mouseout", "div.selectable", function() {
//  var el = $(this);
//  // Raise an event to signal that the value changed
//  el.trigger("change");
//});


var annotateBinding = new Shiny.InputBinding();

$.extend(annotateBinding, {
  find: function(scope) {
    return $(scope).find("div.inputAnnotate");
  },
  getValue: function(el) {
        var start = 0, end = 0, txt = "";
        txt = $(el).text();
    var sel, range, priorRange, selectedText;
    if (typeof window.getSelection != "undefined") {
      if (window.getSelection().rangeCount > 0){
             range = window.getSelection().getRangeAt(0);
        priorRange = range.cloneRange();
        priorRange.selectNodeContents(el);
        priorRange.setEnd(range.startContainer, range.startOffset);
        start = priorRange.toString().length;
        end = start + range.toString().length;
        selectedText = window.getSelection();
      }

    } else if (typeof document.selection != "undefined" &&
            (sel = document.selection).type != "Control") {
        range = sel.createRange();
        priorRange = document.body.createTextRange();
        priorRange.moveToElementText(el);
        priorRange.setEndPoint("EndToStart", range);
        start = priorRange.text.length;
        end = start + range.text.length;
        selectedText = document.selection.createRange().text;
    }
    //alert(selectedText);
    start = start + 1;
    return {"start":start,"end":end,"txt":txt, "selectedText":selectedText};
  },
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change.annotateBinding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".annotateBinding");
  }
});

Shiny.inputBindings.register(annotateBinding);
