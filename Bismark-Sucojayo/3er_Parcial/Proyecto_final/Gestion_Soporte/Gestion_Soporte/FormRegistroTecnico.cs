using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Gestion_Soporte
{
    public partial class FormRegistroTecnico : Form
    {
        public FormRegistroTecnico()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            // 1. Validación rápida: No dejar campos vacíos importantes
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                MessageBox.Show("Por favor, completa los campos obligatorios (Nombre, Correo y Contraseña).");
                return;
            }

            CConexion objetoConexion = new CConexion();

            // Consulta SQL con CURDATE() para la fecha automática
            string query = "INSERT INTO Tecnico (nombre, apellido, ci, especialidad, telefono, correo_institucional, password, fecha_ingreso, estado_tecnico, nivel_acceso) " +
                           "VALUES (@nom, @ape, @ci, @esp, @tel, @mail, @pass, CURDATE(), @est, @niv)";

            try
            {
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());

                // Mapeo de parámetros desde tus TextBoxes y ComboBoxes
                cmd.Parameters.AddWithValue("@nom", txtNombre.Text);
                cmd.Parameters.AddWithValue("@ape", txtApellido.Text);
                cmd.Parameters.AddWithValue("@ci", txtCI.Text);
                cmd.Parameters.AddWithValue("@esp", txtEspecialidad.Text);
                cmd.Parameters.AddWithValue("@tel", txtTelefono.Text);
                cmd.Parameters.AddWithValue("@mail", txtEmail.Text);
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text);

                // Obtenemos el texto seleccionado de los combos
                cmd.Parameters.AddWithValue("@est", cmbEstado.Text);
                cmd.Parameters.AddWithValue("@niv", cmbNivel.Text);

                cmd.ExecuteNonQuery();

                MessageBox.Show("¡Técnico registrado con éxito!");

                // Cerramos esta ventana y regresamos al Form1
                this.Close();

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al guardar en la base de datos: " + ex.Message);
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
