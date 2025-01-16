@echo off
REM Chemin du projet
set PROJECT_PATH=C:\itu\s5\MmeBaovola\boulangerie

REM Nom du fichier WAR généré
set WAR_FILE=boulangerie-1.0-SNAPSHOT.war

REM Nom du fichier WAR dans le dossier webapps (nouveau nom)
set FINAL_WAR_NAME=boulangerie.war

REM Chemin de destination (webapps dans Tomcat)
set TOMCAT_WEBAPPS_PATH=C:\Program Files\Apache Software Foundation\Tomcat 10.1_Tomcat100\webapps
@REM set TOMCAT_WEBAPPS_PATH=D:\wildfly-10.0.0.Final\standalone\deployments



REM Vérifier si le fichier WAR existe
if exist "%PROJECT_PATH%\target\%WAR_FILE%" (
    echo Copie et renommage du fichier WAR dans le dossier webapps de Tomcat...
    REM Utiliser des guillemets pour éviter les erreurs liées aux espaces
    copy "%PROJECT_PATH%\target\%WAR_FILE%" "%TOMCAT_WEBAPPS_PATH%\%FINAL_WAR_NAME%" /Y
    echo Le fichier WAR a ete copie et renomme en %FINAL_WAR_NAME% dans %TOMCAT_WEBAPPS_PATH%
) else (
    echo Erreur : Le fichier WAR n'existe pas à l'emplacement %PROJECT_PATH%\target\%WAR_FILE%
)

