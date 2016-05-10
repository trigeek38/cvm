<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../docs-assets/ico/favicon.png">
    <link href='http://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
    <link href="//vjs.zencdn.net/4.2/video-js.css" rel="stylesheet">
    <script src="//vjs.zencdn.net/4.2/video.js"></script>

    <title>CVM - Hotseat</title>

    {% block html_head_extra %}{% endblock %}

    <!-- Bootstrap core CSS -->
    {% lib
            "css/jquery.loadmask.css"
            "css/z.growl.css"
            "css/z.modal.css"
    %}

    {% lib "cvm/css/bootstrap.css" "cvm/css/bootstrap-theme.css" %}
    {% lib "css/site.css" %}

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../docs-assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 su
rt of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
<style>
/* Sticky footer styles
-------------------------------------------------- */
html,
body {
  height: 100%;
  /* The html and body elements cannot have any padding or margin. */
}

/* Wra
  <  ge content to push down footer */
#wrap {
  min-height: 100%;
  height: auto;
  /* Negative indent footer by its height */
  margin: 0 auto -60px;
  /* Pad bottom by footer height */
  padding: 0 0 60px;
}

/* Set the fixed height of the footer here */
#footer {
  height: 60px;
  background-color: #f5f5f5;
}


/* Custom page CSS
-------------------------------------------------- */
/* Not required for template or sticky footer method. */

#wrap > .container {
  padding: 60px 15px 0;
}
.container .text-muted {
  margin: 20px 0;
}

#footer > .container {
  padding-left: 15px;
  padding-right: 15px;
}

code {
  font-size: 80%;
}
</style>
<head>

  <body>

    <!-- Wrap all page content here -->
    <div id="wrap">

      <!-- Fixed navbar -->
      <div class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">CVM Applications</a>
          </div>
          <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
              {#<li class="active"><a href="#">Home</a></li>
              <li><a href="#about">About</a></li>
              <li><a href="#contact">Contact</a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                <ul class="dropdown-menu">
                  <li><a href="#">Action</a></li>
                  <li><a href="#">Another action</a></li>
                  <li><a href="#">Something else here</a></li>
                  <li class="divider"></li>
                  <li class="dropdown-header">Nav header</li>
                  <li><a href="#">Separated link</a></li>
                  <li><a href="#">One more separated link</a></li>
                </ul>
              </li> #}
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>

      <!-- Begin page content -->
      <div class="container">
        <div class="page-header">
          <h1>EndoView</h1>
        </div>
        <p class="lead">Endoscopy Review Application</p>
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-primary">
              <div class="panel-heading"> {{q.img }}</div>
              <div class="panel-body">
                {% with m.rsc[329] as id %}
                    <p><b>Name:</b> {{ id.patient_last }}, {{ id.patient_first }}</p>
                    <p><b>Id:</b> {{ id.patient_id }}</p>
                    <p><b>Description:</b> {{ id.description }} </p>
                    <p><b>Study Path:</b> {{ id.path }}</p>
              </div>
            </div>
           </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="panel panel-primary">
              <div class="panel-heading"> {{q.img }}</div>
              <div class="panel-body">
                  <video id="example_video_1" class="video-js vjs-default-skin center-block"
                      controls preload="auto" width="390" height="160"
                      poster="/lib/images/endo_archive/{{id.path}}/{{q.thumb}}"
                      data-setup='{"example_option":true}'>
                      <source src="/lib/images/endo_archive/{{id.path}}/videos/{{q.img}}" type='video/mp4' />
                  </video>
                {% endwith %}
              </div>
            </div>
           </div>
        </div>
      </div>

    </div>

    <div id="footer">
      <div class="container">
        <p class="text-muted"><img src="/lib/images/UFsig_small.gif"> University of Florida - College of Veterinary Medicine - CVM Applications Crew</p>
      </div>
    </div>


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
{% lib
    "js/apps/jquery-latest.min.js"
%}
{% lib
    "js/apps/jquery-ui-latest.min.js"
    "js/modules/jquery.ui.touch-punch.min.js"
%}

{% lib
    "js/apps/zotonic-1.0.js"
    "js/apps/z.widgetmanager.js"
    "js/modules/z.notice.js"
    "js/modules/z.imageviewer.js"
    "js/modules/z.dialog.js"
    "js/modules/livevalidation-1.3.js"
    "js/modules/z.inputoverlay.js"
    "js/modules/jquery.loadmask.js"
%}

{% block _js_include_extra %}{% endblock %}

<script type="text/javascript">
    $(function()
    {
        $.widgetManager();
    });
</script>

    {% lib "cvm/js/bootstrap.min.js" %}
    {% script %}

{% block ua_probe %}
    {% include "_ua_probe.tpl"%}
{% endblock %}

  </body>
</html>

