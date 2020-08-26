$(document).on('turbolinks:load', ()=> {
  const buildFileField =(index)=> {
    const html = `<label class="image_upload__btn" for="product_product_images_attributes_${index}_image_url">
                    <div class="btn_contents">
                      <i class="fas fa-camera fa-2x"></i>
                      <input class="file" type="file" name="product[product_images_attributes][${index}][image_url]" id="product_product_images_attributes_${index}_image_url">
                      <div class="remove_image">削除</div>
                    </div>
                  </label>`;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];

  $('.image_upload').on('change', '.file', function(e) {
    $('.image_upload').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('.image_upload').on('click', '.remove_image', function() {
    $(this).parents('.image_upload__btn').remove();
    if ($('.file').length == 0) $('.image_upload').append(buildFileField(fileIndex[0]));
  });
});