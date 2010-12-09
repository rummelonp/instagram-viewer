(function() {

  var getParentElementByAttributeRegExp = function(element, attribute, regexp) {
    var parent_element = $(element);
    do {
      if (regexp.test(parent_element.readAttribute(attribute))) {
        return parent_element;
      }
      parent_element = $(parent_element.parentNode);
    } while (parent_element);
    return null;
  };

  Object.extend(Element.prototype, {
    getParentElementByAttributeRegExp: getParentElementByAttributeRegExp.methodize()
  });

  var showFullPost = function(post) {
    post = $(post);
    $$('#full').each(function(e) e.writeAttribute('id', null));
    post.writeAttribute('id', 'full');
  };

  var showFullPostFirst = function() {
    var post = $$('.post').first();
    showFullPost(post);
  };

  var onClickDocument = function(event) {
    var target = $(event.target);

    var photo = target.getParentElementByAttributeRegExp('class', /thumbnail/);
    if (photo) {
      event.stop();
      var post = photo.getParentElementByAttributeRegExp('class', /post/);
      showFullPost(post);
    }
  };

  var loadFullPhoto = function() {
    var addSrcFromRel = function(element) {
      element.writeAttribute('src', element.readAttribute('rel'));
    };
    return function() {
      $$('.full ..photo img').each(addSrcFromRel);
    };
  }();

  document.observe('dom:loaded', showFullPostFirst, false);

  Event.observe(window, 'load', loadFullPhoto, false);

  document.observe('click', onClickDocument.bindAsEventListener(), false);

})();
