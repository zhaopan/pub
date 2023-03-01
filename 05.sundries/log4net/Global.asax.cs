private void Application_Start(object sender, EventArgs e)
{
    log4net.Config.XmlConfigurator.Configure();
    LogOuts.Info("Service Started");
}
