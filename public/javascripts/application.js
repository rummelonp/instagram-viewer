var showFullPost = function(post_id) {
  var before = document.getElementById('full');
  if (before) {
    before.id = '';
  }
  var current = document.getElementsByClassName(post_id)[0];
  current.id = 'full';
  return before === current;
};

window.onload = function() {
  var post = document.getElementById('full');
  if (!post) {
    document.getElementsByClassName('post')[0].id = 'full';
  }
};
