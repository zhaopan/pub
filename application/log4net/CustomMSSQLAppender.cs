using System;
using System.Data;
using log4net.Appender;

namespace System
{
    public class CustomMSSQLAppender : AdoNetAppender
    {
        protected override IDbConnection CreateConnection(Type connectionType, string connectionString)
        {
            var connStr = EncryptTools.Decrypt(connectionString);
            return base.CreateConnection(connectionType, connStr);
        }
    }
}
