$(function(){
  // カテゴリーボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childHtml = '';
    childHtml = `<div class="category__child" id="children_wrapper">
                  <select id="child__category" name="product[category_id]" class="selectbox_style mb_30">
                    <option value="">---</option>
                    ${insertHTML}
                  </select>
                </div>`;
    $('.append__category').append(childHtml);
  }

  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML){
    var grandchildHtml = '';
    grandchildHtml = `<div class="category__child" id="grandchildren_wrapper">
                        <select id="grandchild__category" name="product[category_id]" class="selectbox_style mb_30">
                          <option value="">---</option>
                          ${insertHTML}
                          </select>
                      </div>`;
    $('.append__category').append(grandchildHtml);
  }
