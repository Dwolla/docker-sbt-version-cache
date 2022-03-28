lazy val app = (project in file("."))
  .settings(
    name := "fake-project",
    organization := "com.dwolla",
    version := "0.0.1",
    scalaVersion := "2.13.8",
    crossScalaVersions := Seq(
      "2.11.12",
      "2.12.15",
      "2.13.8",
      "3.1.1",
    ),
)
