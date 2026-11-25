<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
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
        <h1 class="sitename">An Al-Enabled Federated Edge-Cloud Communication Framework for Dynamic Task Offloading and Network Anomaly Detection in IoT System</h1>
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="ohome.jsp" >Home</a></li>
          <li><a href="upload.jsp">Upload</a></li>
           <li><a href="mf.jsp">My Files</a></li>
            <li><a href="os.jsp">Status</a></li>
          <li><a href="dataset.jsp" class="active">Dataset</a></li>
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
          String appPath = application.getRealPath("/");
          File csvFile = new File(appPath, "../network_anomaly_dataset_records_rule_based).csv");
          if (!csvFile.exists()) {
              csvFile = new File(appPath, "../../network_anomaly_dataset_records_rule_based).csv");
          }
          List<String[]> rows = new ArrayList<>();
          String[] headers = null;
          int displayLimit = 50;

          if (csvFile.exists()) {
              BufferedReader br = new BufferedReader(new FileReader(csvFile));
              String line;
              int count = 0;
              while ((line = br.readLine()) != null && count < displayLimit + 1) {
                  String[] cols = line.split(",");
                  if (count == 0) {
                      headers = cols;
                  } else {
                      rows.add(cols);
                  }
                  count++;
              }
              br.close();
          } else {
          %>
            <div class="alert alert-danger">CSV file not found. App path: <%=appPath%><br>Looking at: <%=csvFile.getAbsolutePath()%></div>
          <%
          }
          %>
        <div class="container">
          <h3 class="text-center mb-4">Network Anomaly Dataset (First 50 Records)</h3>
          <div class="table-responsive">
            <table class="table table-dark table-hover table-bordered">
              <thead>
                <tr>
                  <%
                  if (headers != null) {
                      for (String h : headers) {
                  %>
                    <th><%=h%></th>
                  <%
                      }
                  }
                  %>
                </tr>
              </thead>
              <tbody>
                <%
                for (String[] row : rows) {
                %>
                <tr>
                  <%
                  for (String cell : row) {
                  %>
                    <td><%=cell%></td>
                  <%
                  }
                  %>
                </tr>
                <%
                }
                %>
              </tbody>
            </table>
          </div>
          <p class="text-center mt-3">Showing <%=rows.size()%> of 500 total records</p>
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
