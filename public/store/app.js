document.addEventListener("DOMContentLoaded", function(event) { 
  
  var hooks = document.getElementsByClassName("reaction-buttons");

  if(hooks.length < 1)
    return;

  for(var i = hooks.length - 1; i >= 0; i--) {
    hooks[i].innerHTML = reactions.buttonHTML();
  }

});

var reactions = {
  buttonHTML: function() {
    return '<button type="button" onclick="reactions.send(\'Reaction 1\');">Reaction 1</button> &nbsp; <button type="button" onclick="reactions.send(\'Reaction 2\');">Reaction 2</button>';
  },
  send: function(reaction) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', encodeURI('http://104.197.196.69/create-reaction'));
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function() {
      console.log(xhr.status);
      console.log(xhr.responseText);
    };
    xhr.send(encodeURI('name=' + reaction + '&referrer=' + document.referrer ));
  }
}
