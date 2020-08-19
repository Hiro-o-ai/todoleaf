// window.onload = function() {
//   document.querySelectorAll('td').forEach(function(td) {
//     td.addEventListener('mouseover', function(e) {
//       e.currentTarget.style.backgroundColor = '#eff';
//     });

//     td.addEventListener('mouseover', function(e) {
//       e.currentTarget.style.backgroundColor = '';
//     });
//   });
// };

document.addEventListener('turbolinks:load', function() {
  document.querySelectorAll('td').forEach(function(td) {
    td.addEventListener('mouseover', function(e) {
      e.currentTarget.style.backgroundColor = '#eff';
    });

    td.addEventListener('mouseout', function(e) {
      e.currentTarget.style.backgroundColor = '';
    });
  });
});

// document.addEventListener('turbolinks:load', function() {
//   document.querySelectorAll('.delete').forEach(function(a) {
//     // ajax:successイベントに対応する処理となる
//     a.addEventListener('ajax:success', function() {
//       // parentNodeは親要素を返す
//       var td = a.parentNode;
//       var tr = td.parentNode;
//       tr.style.display = 'none';
//     });
//   });
// });