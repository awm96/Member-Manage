<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="utf-8">
    <title>大众天成会员管理系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Member Management System">
    <meta name="author" content="Ligq">

    <!-- The styles -->
    <link id="bs-css" href="${req.contextPath}/charisma/css/bootstrap-cerulean.min.css" rel="stylesheet">

    <link href="${req.contextPath}/charisma/css/charisma-app.css" rel="stylesheet">
    <link href='${req.contextPath}/charisma/bower_components/fullcalendar/dist/fullcalendar.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/bower_components/fullcalendar/dist/fullcalendar.print.css' rel='stylesheet' media='print'>
    <link href='${req.contextPath}/charisma/bower_components/chosen/chosen.min.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/bower_components/colorbox/example3/colorbox.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/bower_components/responsive-tables/responsive-tables.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/jquery.noty.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/noty_theme_default.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/elfinder.min.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/elfinder.theme.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/jquery.iphone.toggle.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/uploadify.css' rel='stylesheet'>
    <link href='${req.contextPath}/charisma/css/animate.min.css' rel='stylesheet'>
    <!-- The fav icon -->
    <link rel="shortcut icon" href="${req.contextPath}/images/favicon.ico">

    <!-- jQuery -->
    <script src="${req.contextPath}/charisma/bower_components/jquery/jquery.min.js"></script>

    <!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- external javascript -->

    <script src="${req.contextPath}/charisma/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- library for cookie management -->
    <script src="${req.contextPath}/charisma/js/jquery.cookie.js"></script>
    <!-- calender plugin -->
    <script src='${req.contextPath}/charisma/bower_components/moment/min/moment.min.js'></script>
    <script src='${req.contextPath}/charisma/bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
    <!-- data table plugin -->
    <script src='${req.contextPath}/charisma/js/jquery.dataTables.min.js'></script>

    <!-- select or dropdown enhancer -->
    <script src="${req.contextPath}/charisma/bower_components/chosen/chosen.jquery.min.js"></script>
    <!-- plugin for gallery image view -->
    <script src="${req.contextPath}/charisma/bower_components/colorbox/jquery.colorbox-min.js"></script>
    <!-- notification plugin -->
    <script src="${req.contextPath}/charisma/js/jquery.noty.js"></script>
    <!-- library for making tables responsive -->
    <script src="${req.contextPath}/charisma/bower_components/responsive-tables/responsive-tables.js"></script>
    <!-- tour plugin -->
    <script src="${req.contextPath}/charisma/bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
    <!-- star rating plugin -->
    <script src="${req.contextPath}/charisma/js/jquery.raty.min.js"></script>
    <!-- for iOS style toggle switch -->
    <script src="${req.contextPath}/charisma/js/jquery.iphone.toggle.js"></script>
    <!-- autogrowing textarea plugin -->
    <script src="${req.contextPath}/charisma/js/jquery.autogrow-textarea.js"></script>
    <!-- multiple file upload plugin -->
    <script src="${req.contextPath}/charisma/js/jquery.uploadify-3.1.min.js"></script>
    <!-- history.js for cross-browser state change on ajax -->
    <script src="${req.contextPath}/charisma/js/jquery.history.js"></script>
    <!-- application script for Charisma demo -->
    <script src="${req.contextPath}/charisma/js/charisma.js"></script>

</head>

<body>
<div class="ch-container">
    <div class="row">

        <div class="row">
            <div class="col-md-12 center login-header">
                <img src="${req.contextPath}/images/logo.png"/>
                <img src="${req.contextPath}/images/slogan.png"/>
            </div>
            <!--/span-->
        </div><!--/row-->

        <div class="row">
            <div class="well col-md-5 center login-box">
                <div class="alert alert-info">
                    请输入身份证号、密码登陆
                </div>
                <form class="form-horizontal" action="index.html" method="post">
                    <fieldset>
                        <div class="input-group input-group-lg">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user red"></i></span>
                            <input type="text" class="form-control" placeholder="身份证号">
                        </div>
                        <div class="clearfix"></div>
                        <br>

                        <div class="input-group input-group-lg">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock red"></i></span>
                            <input type="password" class="form-control" placeholder="密码">
                        </div>
                        <div class="clearfix"></div>
                        <p class="center col-md-5">
                            <button type="submit" class="btn btn-primary">登陆</button>
                        </p>
                    </fieldset>
                </form>
            </div>
            <!--/span-->
        </div><!--/row-->
    </div><!--/fluid-row-->

</div><!--/.fluid-container-->
</body>
</html>
