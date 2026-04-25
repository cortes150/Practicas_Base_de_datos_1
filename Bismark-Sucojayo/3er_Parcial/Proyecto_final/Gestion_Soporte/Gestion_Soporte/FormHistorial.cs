using Gestion_Soporte;
using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Windows.Forms;
namespace Gestion_Soporte {
    public partial class FormHistorial : Form
    {
        // ESTA LÍNEA ES VITAL: Declara la variable para toda la clase
        private int idOrdenRecibido;

        public FormHistorial()
        {
            InitializeComponent();
        }

        public FormHistorial(int idOrden) : this()
        {
            // Corregimos para que use idOrden
            this.idOrdenRecibido = idOrden;
            cargarHistorial();
        }

        private void cargarHistorial()
        {
            CConexion objetoConexion = new CConexion();

            // 1. Aquí definimos la consulta (Asegúrate que los nombres de tablas coincidan con MySQL)
            string query = @"SELECT H.fecha_hora AS 'Fecha/Hora', 
                            T.nombre AS 'Técnico', 
                            H.estado AS 'Estado', 
                            H.observaciones AS 'Observaciones'
                     FROM Historial_Estado H
                     JOIN Tecnico T ON H.id_tecnico = T.id_tecnico
                     WHERE H.id_orden = @id
                     ORDER BY H.fecha_hora DESC";

            try
            {
                // 2. AQUÍ SE CREA EL 'cmd'. Sin esta línea, sale el error que tienes.
                MySqlCommand cmd = new MySqlCommand(query, objetoConexion.establecerConexion());

                // 3. Ahora sí, le pasamos el ID de la orden
                cmd.Parameters.AddWithValue("@id", idOrdenRecibido);

                // 4. Llenamos la tabla (dgvHistorial)
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                dgvHistorial.DataSource = dt;

                objetoConexion.cerrarConexion();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar el historial: " + ex.Message);
            }
        }
    }
}