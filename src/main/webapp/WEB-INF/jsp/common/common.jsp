<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String basePath = request.getContextPath();
    request.setAttribute("basePath", basePath);
%>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1" name="viewport"/>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet"
      type="text/css"/>
<link href="${basePath}/static/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
      type="text/css"/>
<link href="${basePath}/static/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet"
      type="text/css"/>
<link href="${basePath}/static/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}/static/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet"
      type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<link href="${basePath}/static/assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}/static/assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet"
      type="text/css"/>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL STYLES -->
<link href="${basePath}/static/assets/global/css/components.min.css" rel="stylesheet" id="style_components"
      type="text/css"/>
<link href="${basePath}/static/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css"/>
<!-- BEGIN THEME LAYOUT STYLES -->
<link href="${basePath}/static/assets/layouts/layout3/css/layout.min.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}/static/assets/layouts/layout3/css/themes/default.min.css" rel="stylesheet" type="text/css"
      id="style_color"/>
<link href="${basePath}/static/assets/layouts/layout3/css/custom.min.css" rel="stylesheet" type="text/css"/>
<!-- END THEME GLOBAL STYLES -->
<link rel="shortcut icon" href="${basePath}/favicon.ico"/>
<link href="${basePath}/static/bootstarp-table/bootstrap-table.min.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}/static/css/jquery.datetimepicker.css" rel="stylesheet" type="text/css"/>
<link href="${basePath}/static/css/common.css" rel="stylesheet" type="text/css"/>

<!--[if lt IE 9]>
<script src="${basePath}/static/assets/global/plugins/respond.min.js"></script>
<script src="${basePath}/static/assets/global/plugins/excanvas.min.js"></script>
<script src="${basePath}/static/assets/global/plugins/ie8.fix.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${basePath}/static/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js"  type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${basePath}/static/assets/global/plugins/jquery-validation/js/jquery.validate.min.js"
        type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/jquery-validation/js/additional-methods.min.js"
        type="text/javascript"></script>
<script src="${basePath}/static/assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${basePath}/static/assets/global/scripts/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<script src="${basePath}/static/js/md5.js"></script>
<script src="${basePath}/static/bootstarp-table/bootstrap-table.min.js" type="text/javascript"></script>
<script src="${basePath}/static/bootstarp-table/locale/bootstrap-table-zh-CN.min.js" type="text/javascript"></script>
<script src="${basePath}/static/bootstarp-table/extensions/export/bootstrap-table-export.min.js"
        type="text/javascript"></script>
<script src="${basePath}/static/layer/layer.js" type="text/javascript"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript" src="${basePath}/static/js/common/jquery-form.js"></script>
<script type="text/javascript" src="${basePath}/static/js/common/build/jquery.datetimepicker.full.js"></script>
<script type="text/javascript" src="${basePath}/static/js/common/common.js"></script>
<script>
    function myPage(params) {
        var limit = params.limit;
        params.pageNum = params.offset / limit + 1;
        params.pageSize = limit;
        return params;
    }
    
    //自定义HashMap
    function HashMap() {
 	   /**
 	    * 存放数据
 	    */
 	   this.data = new Object();
 	   
 	   /**
 	    * 放入一个键值对
 	    * @param {String} key
 	    * @param {Object} value
 	    */
 	   this.put = function(key, value) 
 	   {
 	      this.data[key] = value;
 	   };
 	   
 	   /**
 	    * 获取某键对应的值
 	    * @param {String} key
 	    * @return {Object} value
 	    */
 	   this.get = function(key) 
 	   {
 	      return this.containsKey(key)?this.data[key]:null;  
 	   };
 	   
 	   /**
 	    * 删除一个键值对
 	    * @param {String} key
 	    */
 	   this.remove = function(key) 
 	   {
 	      delete this.data[key];
 	   };
 	   
 	   /**
 	    * 遍历Map,执行处理函数
 	    * 
 	    * @param {Function} 回调函数 function(key,value,index){..}
 	    */
 	   this.each = function(fn){
 	      if(typeof fn != 'function')
 	      {
 	         return;
 	      }
 	      var len = this.data.length;
 	      for(var i=0;i<len;i++)
 	      {
 	         var k = this.data[i];
 	         fn(k,this.data[k],i);
 	      }
 	   };
 	   
 	   /**
 	    * 获取键值数组(类似Java的entrySet())
 	    * @return 键值对象{key,value}的数组
 	    */
 	   this.entrys = function() 
 	   {
 	      var len = this.data.length;
 	      var entrys = new Array(len);
 	      for (var i = 0; i < len; i++) {
 	         entrys[i] = {
 	            key : i,
 	            value : this.data[i]
 	         };
 	      }
 	      return entrys;
 	   };
 	   
 	   /**
 	    * 判断Map是否为空
 	    */
 	   this.isEmpty = function() 
 	   {
 	      return this.data.length == 0;
 	   };
 	   
 	   /**
 	    * 获取键值对数量
 	    */
 	   this.size = function()
 	   {
 	      return this.data.length;
 	   };
 	   
 	   /**
 	    * 重写toString ,装成JSON格式
 	    */
 	   this.toString = function()
 	   {
 	      var s = "[";
 	      for(var i=0;i<this.data.length;i++,s+=','){
 	         var k = this.data[i];
 	         s += "{'id':'" + k+"','value':'"+this.data[k]+"'}";
 	      }
 	      s=s.substring(0, s.length-1);
 	      if(s!=""){
 	         s+="]";
 	      }
 	      return s;
 	   };
 	   
 	   /**
 	    * 输出Value的值
 	    */
 	   this.values = function (){
 	      var _values= new Array();  
 	        for(var key in this.data)
 	        {  
 	            _values.push(this.data[key]);  
 	        }  
 	        return _values;  
 	   };
 	   
 	   /**
 	    * 获取keys
 	    */
 	   this.keySet = function (){
 	      var _keys = new Array();  
 	        for(var key in this.data)
 	        {  
 	            _keys.push(key);  
 	        }  
 	        return _keys;  
 	   };
 	   
 	   /**
 	    * 判断MAP中是否含有指定KEY的元素   
 	    */
 	    this.containsKey = function(_key)
 	    {   
 	       return (_key in this.data);  
 	    };   
 	 
 	    /** 
 	     * 清空Map 
 	     */  
 	    this.clear = function(){  
 	       this.data.length = 0;
 	        this.data = new Object();
 	    }; 
 	}
    
   user = '${currentUser}';
   
   roleControl = '${currentUserAuthority}';

</script>
