
using MySql.Data.MySqlClient;
using System;
using System.Windows.Forms;

namespace Gestion_Soporte{
    internal class CConexion {
        // Datos de tu servidor local
        string servidor = "localhost";
        string bd = "soporte_tecnico";
        string usuario = "root";
        string password = "Formula1redbull181@"; // <--- Cambia esto por tu clave de Workbench
        string puerto = "3307";

        MySqlConnection conex = new MySqlConnection();

        public MySqlConnection establecerConexion(){
            string cadenaConexion = "server=" + servidor + ";port=" + puerto + ";user id=" + usuario + ";password=" + password + ";database=" + bd;

            try{
                conex.ConnectionString = cadenaConexion;
                conex.Open();
                // MessageBox.Show("Se conectó correctamente a la base de datos"); // Opcional para pruebas
            }
            catch (MySqlException e){
                MessageBox.Show("No se pudo conectar a la base de datos: " + e.Message);
            }
            return conex;
        }

        public void cerrarConexion(){
            conex.Close();
        }
    }
}