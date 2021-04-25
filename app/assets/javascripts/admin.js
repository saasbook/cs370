//import Sortable from 'sortablejs'
document.addEventListener('turbolinks:load', () => {
  var el = document.getElementById('question-template-list');
  var sortable = Sortable.create(el, {
    animation: 175,
    ghostClass: 'bg-light'
  });
})
