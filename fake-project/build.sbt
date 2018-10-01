lazy val buildSettings = Seq(
  name := "fake-project",
  organization := "com.dwolla",
  version := "0.0.1",
  scalaVersion := "2.12.7",
  crossScalaVersions := Seq(
    "2.11.12",
    "2.12.7",
    "2.13.0-M5"
  )
)

lazy val app = (project in file("."))
  .settings(buildSettings: _*)
