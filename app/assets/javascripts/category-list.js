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
    $.ajax({
      type: 'GET',
      url: '/categories/new',
      data: {parent_id: id}, //どの親の要素かを送る
      dataType: 'json'
    }).done(function(children) {
      children.forEach(function (child) { //帰ってきた子カテゴリー（配列）を
        var html = buildChildHTML(child); //HTMLにして
        $(".children_list").append(html); //リストに追加する
      })
    });
  });
