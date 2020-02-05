
//图片预览，兼容各个浏览器
function previewImage(file,imgId) {
   var porImg  = $(file),
       viewImg = $("#"+imgId);
   var image = porImg.val();
   if (!/^\S*\.(?:png|jpe?g|bmp|gif)$/i.test(image)) {
       layer.msg('请选择图片~', {shift: 6});
       porImg.val("");
       return false;
   }
   if (file["files"] && file["files"][0]) {
       var reader = new FileReader();
       reader.onload = function(evt){
           viewImg.attr({src : evt.target.result});
       }
       reader.readAsDataURL(file.files[0]);
   } else {
       var ieImageDom = document.createElement("div");
       var proIeImageDom = document.createElement("div");
       $(ieImageDom).css({
           float: 'left',
           position: 'relative',
           overflow: 'hidden',
           width: '100px',
           height: '100px'
       }).attr({"id":"view"});
       $(proIeImageDom).attr({"id": porImg.attr("id")});
       porImg.parent().prepend(proIeImageDom);
       porImg.remove();
       file.select();
       path = document.selection.createRange().text;
       $(ieImageDom).css({"filter": "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")"});
   }
}

//点击默认图片选中打开文件选择器
function openBrowse(fileId){
	var ie=navigator.appName=="Microsoft Internet Explorer" ? true : false; 
	if(ie){ 
		document.getElementById(fileId).click(); 
	}else{
		var a=document.createEvent("MouseEvents");//FF的处理 
		a.initEvent("click", true, true);  
		document.getElementById(fileId).dispatchEvent(a); 
	} 
}


//判断是否为空
function isEmpty(value){
	if(value==null||value=="")
		return true;
	return false;
}






