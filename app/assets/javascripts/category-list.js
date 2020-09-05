$(function() {
  // 子カテゴリーを追加する処理
  function buildChildHTML(child){
    var html =`<a class="child_category" id="${child.id}" href="/category/${child.id}">${child.name}</a>`;
    return html;
  }
