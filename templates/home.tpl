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
          <h1>DICOM/HL7 Test Server</h1>
        </div>
        <p class="lead">Provides basic Dicom SCP and HL7 receive capabilities for testing</p>
        <div class="row">
          <div class="col-md-6">
            <div class="panel panel-primary">
              <div class="panel-heading"><h3 class="panel-title">Available DICOM ports</h3></div>
              <div class="panel-body">
                <p>Below is a list of the current available DICOM port.</p>
                {% if m.dcm4chee.ports %}
                <table class="table">
                <tr><th>Port</th><th>Start</th></tr>
                {% for f in  m.dcm4chee.ports %}
                  <tr>
                    <td>{{ f }}</td>
                    <td><a href="#" id="{{#start.f}}"><span class="glyphicon glyphicon-play"></span></a></td>
                    {% wire id=#start.f action={postback postback={start_proc port=f } delegate="mod_dcm4chee"} %}
                  </tr>
                {% endfor %}
                </table>
                {% else %}
                  <div class="alert alert-info">All ports are already open</div>
                {% endif %}
              </div>
            </div>
            <div class="panel panel-primary">
              <div class="panel-heading"><h3 class="panel-title">Open DICOM ports</h3></div>
              <div class="panel-body">
                <p>Below is a list of the current open DICOM ports.</p>
                <p>Files locations: /home/cvm/dicom/cvm/CVMARCHIVE[Port]</p>
                <p>Example: <code>/home/cvm/dicom/cvm/CVMARCHIVE1104</code></p>
                <table class="table">
                <tr><th>Port</th><th>Pid</th><th>Kill</th></tr>
                {% for f in  m.dcm4chee.open_ports %}
                  {% with f.pid as pid %}
                  <tr>
                    <td>{{ f.port }}</td>
                    <td>{{ f.pid }}</td>
                    <td><a href="#" id="{{#remove.pid}}"><span class="glyphicon glyphicon-remove"></span></a></td>
                    {% wire id=#remove.pid action={postback postback={kill_proc port=f.port} delegate="mod_dcm4chee"} %}
                  </tr>
                  {% endwith %}
                {% endfor %}
                </table>
              </div>
            </div>
          </div>
          <div class="col-md-6">

            <div class="panel panel-primary">
              <div class="panel-heading">
                <h3 class="panel-title">HL7 Ports</h3>
              </div>
              <div class="panel-body">
                <p>HL7 messages are stored in <code>/home/cvm/hl7</code></p>
                <table class="table">
                  <tr><th>Pid</th><th>Port</th></tr>
                    <tr>
                      <td>{{ m.dcm4chee.hl7_info.pid }}</td> 
                      <td>{{ m.dcm4chee.hl7_info.port }}
                          {% button class="btn btn-primary pull-right" text="Restart" action={postback postback={start_hl7 hl7_port="5656"} delegate="mod_dcm4chee"} %}
                      </td>
                    </tr> 
                </table>
              </div>
            </div>

            <div class="panel panel-primary">
              <div class="panel-heading"> Example Dicom to jpeg image</div>
              <div class="panel-body">
                <img src="/lib/images/avi.jpeg" height="200" width="200" class="img-rounded">
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
    "js/modules/ubf.js"
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

