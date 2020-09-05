$(function() {
  // 子カテゴリーを追加する処理
  function buildChildHTML(child){
    var html =`<a class="child_category" id="${child.id}" href="/category/${child.id}">${child.name}</a>`;
    return html;
  }

  $(".parent_category").on("mouseover", function() {
    var id = this.id //どのリンクにマウスが乗っているかを取得
    $(".selected-green").removeClass("selected-green") //cssで色を付与する為
    $('#' + id).addClass("selected-green");
    $(".child_category").remove();
    $(".grandchild_category").remove();
