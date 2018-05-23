using System.IO;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MyTests
{
    [TestClass]
    public class UnitTest1
    {
        /// <summary>
        /// Test.txt
        /// </summary>
        //------------------------------
        //MyClassInitialize
        //MyTestInitialize
        //TestMethod2
        //MyTestCleanup
        //MyTestInitialize
        //TestMethod3
        //MyTestCleanup
        //MyTestInitialize
        //TestMethod1
        //MyTestCleanup
        //MyClassCleanup

        private static StreamWriter sw = new StreamWriter("d:\\Test.txt", false);

        [ClassInitialize()]
        public static void MyClassInitialize(TestContext testContext)
        {
            sw.WriteLine("MyClassInitialize");
            sw.Flush();
        }

        [ClassCleanup()]
        public static void MyClassCleanup()
        {
            sw.WriteLine("MyClassCleanup");
            sw.Flush();
        }

        [TestInitialize()]
        public void MyTestInitialize()
        {
            sw.WriteLine("MyTestInitialize");
            sw.Flush();
        }

        [TestCleanup()]
        public void MyTestCleanup()
        {
            sw.WriteLine("MyTestCleanup");
            sw.Flush();
        }

        [TestMethod]
        public void TestMethod1()
        {
            sw.WriteLine("TestMethod1");
            sw.Flush();
        }

        [TestMethod]
        public void TestMethod2()
        {
            sw.WriteLine("TestMethod2");
            sw.Flush();
        }

        [TestMethod]
        public void TestMethod3()
        {
            sw.WriteLine("TestMethod3");
            sw.Flush();
        }
    }
}