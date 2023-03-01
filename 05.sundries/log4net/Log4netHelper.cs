using System.Reflection;

namespace System
{
    public class LogOuts
    {
        public static void Info(string message)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
            if (log.IsInfoEnabled)
            {
                log.Info(message);
            }
        }

        public static void Debug(string message)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
            if (log.IsDebugEnabled)
            {
                log.Debug(message);
            }
        }

        public static void Warn(string message)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
            if (log.IsWarnEnabled)
            {
                log.Warn(message);
            }
        }

        public static void Error(string message)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
            if (log.IsErrorEnabled)
            {
                log.Error(message);
            }
        }

        public static void Fatal(string message)
        {
            log4net.ILog log = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);
            if (log.IsFatalEnabled)
            {
                log.Fatal(message);
            }
        }
    }
}
