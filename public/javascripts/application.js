
var onClickDocument = function(event) {
  var thumbnail = event.findElement('.thumbnail');
  if (Object.isElement(thumbnail)) {
    if (event.altKey || event.ctlrKey ||
        event.metaKey || event.shiftKey)
    {
      return;
    }
    event.stop();
    var current = $('full');
    Object.isElement(current) &&
      current.writeAttribute('id', null);
    var post = event.findElement('.post');
    post.writeAttribute('id', 'full');
  }
};

var onSubmitFindForm = function(event) {
  event.stop();
  var form = event.element();
  form.request({
    onCreate: function() { form.disable(); },
    onComplete: function() { form.enable(); }
  });
};

document.observe('dom:loaded', function(event) {
  var post = $$('.post').first();
  post.writeAttribute('id', 'full');
  var form = $$('#find form').first();
  form.observe('submit', onSubmitFindForm.bindAsEventListener(), false);
}.bindAsEventListener(), false);

document.observe('click', onClickDocument.bindAsEventListener(), false);
