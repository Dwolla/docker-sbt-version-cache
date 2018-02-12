lazy val buildSettings = Seq(
  name := "fake-project",
  organization := "com.dwolla",
  version := "0.0.1",
  scalaVersion := "2.12.4",
  crossScalaVersions := Seq(
    "2.11.8",
    "2.11.11",
    "2.11.12",
    "2.12.1",
    "2.12.2",
    "2.12.3",
    "2.12.4",
    "2.13.0-M3",
  )
)

lazy val app = (project in file("."))
  .settings(buildSettings: _*)
