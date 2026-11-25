<%@page import="java.sql.*"%>
<%@page import="databaseconnection.databasecon"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
   <title>An AI-Enabled Federated Edge-Cloud Communication Framework for Dynamic Task Offloading and Network Anomaly Detection in IoT System</title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <link href="assets/css/main.css" rel="stylesheet">
</head>

<body class="index-page">

  <header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center">

      <a href="index.html" class="logo d-flex align-items-center me-auto">
        <h1 class="sitename">An AI-Enabled Federated Edge-Cloud Communication Framework for Dynamic Task Offloading and Network Anomaly Detection in IoT System</h1>
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="ohome.jsp" >Home</a></li>
          <li><a href="upload.jsp">Upload</a></li>
           <li><a href="mf.jsp" class="active">My Files</a></li>
            <li><a href="os.jsp">Status</a></li>
          <li><a href="index.html">Logout</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>

    </div>
  </header>

  <main class="main">

    <section id="hero" class="hero section dark-background">

      <div id="hero-carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">
          <br><br><br><br><br>
          <%
          String filename = request.getParameter("filename");
          String owner = request.getParameter("owner");
          String cipher = request.getParameter("cipher");
          String skey = request.getParameter("skey");
          String prediction = request.getParameter("prediction");
          String m1 = request.getParameter("m1");
          String m2 = request.getParameter("m2");
          %>
        <div class="container">
          <% if (m1 != null && m1.equals("success")) { %>
            <div class="alert alert-success">
              <h4>Prediction Result: <%=prediction != null ? prediction : "Normal"%></h4>
              <p>Data successfully sent to cloud module.</p>
            </div>
          <% } else if (m2 != null && m2.equals("failed")) { %>
            <div class="alert alert-danger">Failed to send to cloud. Please try again.</div>
          <% } %>
          <div class="card">
            <h3 class="text-center">Network Attack Prediction Form</h3>
            <form action="cloud_submit.jsp" method="POST">
              <input type="hidden" name="filename" value="<%=filename != null ? filename : ""%>">
              <input type="hidden" name="owner" value="<%=owner != null ? owner : ""%>">
              <input type="hidden" name="cipher" value="<%=cipher != null ? cipher : ""%>">
              <input type="hidden" name="skey" value="<%=skey != null ? skey : ""%>">

              <div class="mb-4">
                <input type="text" class="form-control" value="File: <%=filename != null ? filename : ""%>" readonly>
              </div>

              <div class="row">
                <div class="col-md-6 mb-4">
                  <input type="number" name="duration_sec" class="form-control" placeholder="Duration (sec)" required value="<%=request.getParameter("duration_sec") != null ? request.getParameter("duration_sec") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="packet_count" class="form-control" placeholder="Packet Count" required value="<%=request.getParameter("packet_count") != null ? request.getParameter("packet_count") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="bytes_transferred" class="form-control" placeholder="Bytes Transferred" required value="<%=request.getParameter("bytes_transferred") != null ? request.getParameter("bytes_transferred") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="flow_rate" class="form-control" placeholder="Flow Rate" required value="<%=request.getParameter("flow_rate") != null ? request.getParameter("flow_rate") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="failed_logins" class="form-control" placeholder="Failed Logins" required value="<%=request.getParameter("failed_logins") != null ? request.getParameter("failed_logins") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="syn_packets" class="form-control" placeholder="SYN Packets" required value="<%=request.getParameter("syn_packets") != null ? request.getParameter("syn_packets") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="udp_packets" class="form-control" placeholder="UDP Packets" required value="<%=request.getParameter("udp_packets") != null ? request.getParameter("udp_packets") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="tcp_retransmissions" class="form-control" placeholder="TCP Retransmissions" required value="<%=request.getParameter("tcp_retransmissions") != null ? request.getParameter("tcp_retransmissions") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" step="any" name="avg_packet_size" class="form-control" placeholder="Avg Packet Size" required value="<%=request.getParameter("avg_packet_size") != null ? request.getParameter("avg_packet_size") : ""%>">
                </div>
                <div class="col-md-6 mb-4">
                  <input type="number" name="connection_hour" class="form-control" placeholder="Connection Hour (0-23)" min="0" max="23" required value="<%=request.getParameter("connection_hour") != null ? request.getParameter("connection_hour") : ""%>">
                </div>
              </div>

              <div class="d-grid">
                <button type="submit" class="btn btn-custom"><%=prediction != null ? "Update & Send Again" : "Predict & Send to Cloud"%></button>
              </div>
            </form>
          </div>
        </div>

      </div>

    </section>

  </main>
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>

  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>
  <script src="assets/vendor/aos/aos.js"></script>
  <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="assets/vendor/waypoints/noframework.waypoints.js"></script>
  <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

  <script src="assets/js/main.js"></script>

</body>

</html>
