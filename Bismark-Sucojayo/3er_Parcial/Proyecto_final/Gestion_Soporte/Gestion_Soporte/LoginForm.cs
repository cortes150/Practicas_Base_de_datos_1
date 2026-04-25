using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Gestion_Soporte
{
    // UBICACIÓN 1: La clase estática fuera de los formularios
    // Funciona como un contenedor global de datos mientras el programa esté abierto.
    

    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void btnIngresar_Click(object sender, EventArgs e)
        {
            // 1. Validación inicial: ¡No gastes recursos si no escribieron nada!
            if (string.IsNullOrEmpty(txtUsuario.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                MessageBox.Show("Por favor, ingresa tu correo y contraseña.");
                return;
            }

            CConexion objetoConexion = new CConexion();
            string query = "SELECT id_tecnico, nombre, nivel_acceso FROM Tecnico " +
                           "WHERE correo_institucional = @user AND password = @pass";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());
                cmd.Parameters.AddWithValue("@user", txtUsuario.Text);
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read()) // Usamos Read() directamente, es más eficiente que HasRows
                {
                    // Guardamos los datos en la clase global
                    UsuarioSesion.idTecnico = Convert.ToInt32(reader["id_tecnico"]);
                    UsuarioSesion.nombreTecnico = reader["nombre"].ToString();
                    UsuarioSesion.nivelAcceso = reader["nivel_acceso"].ToString();

                    MessageBox.Show("¡Bienvenido " + UsuarioSesion.nombreTecnico + "!\nNivel: " + UsuarioSesion.nivelAcceso);

                    // Cerramos conexión antes de saltar de pantalla
                    objetoConexion.cerrarConexion();

                    Form1 principal = new Form1();
                    principal.Show();
                    this.Hide();
                }
                else
                {
                    MessageBox.Show("Credenciales incorrectas. Verifica tu correo y contraseña.");
                    objetoConexion.cerrarConexion();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error crítico: " + ex.Message);
            }
        }

        private void lblPassword_Click(object sender, EventArgs e)
        {

        }
    }
    public static class UsuarioSesion
    {
        public static int idTecnico;
        public static string nombreTecnico;
        public static string nivelAcceso;
    }
}