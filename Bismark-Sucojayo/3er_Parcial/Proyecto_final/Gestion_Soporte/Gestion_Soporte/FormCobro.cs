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
    public partial class FormCobro : Form
    {
        decimal totalAPagar;
        public bool PagoConfirmado { get; private set; }
        public string MetodoSeleccionado { get; private set; }
        public string Referencia { get; private set; }

        public FormCobro(decimal total)
        {
            InitializeComponent();
            totalAPagar = total;
            lblTotal.Text = "Total a Pagar: " + total.ToString("N2") + " Bs.";
            txtPagaCon.Enabled = false; // Bloqueado hasta elegir método
        }

        private void cmbMetodo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string metodo = cmbMetodo.Text;
            // Solo habilitamos cambio para Efectivo y Tarjeta (según tu requerimiento)
            bool requiereCambio = (metodo == "Efectivo" || metodo == "Tarjeta");

            txtPagaCon.Enabled = requiereCambio;
            if (!requiereCambio)
            {
                txtPagaCon.Text = totalAPagar.ToString();
                lblCambio.Text = "Cambio: 0.00 Bs.";
            }
        }

        private void txtPagaCon_TextChanged(object sender, EventArgs e)
        {
            // Si el cuadro está vacío, reseteamos el label
            if (string.IsNullOrEmpty(txtPagaCon.Text))
            {
                lblCambio.Text = "Cambio: 0.00 Bs.";
                return;
            }

            if (decimal.TryParse(txtPagaCon.Text, out decimal paga))
            {
                decimal cambio = paga - totalAPagar;
                // Mostramos el cambio solo si es positivo, si no, 0.00
                lblCambio.Text = "Cambio: " + (cambio > 0 ? cambio.ToString("N2") : "0.00") + " Bs.";
            }
        }

        private void btnConfirmar_Click(object sender, EventArgs e)
        {
            this.MetodoSeleccionado = cmbMetodo.Text;
            this.Referencia = txtComprobante.Text;
            this.PagoConfirmado = true;
            this.Close();
        }

        private void btnConfirmar_Click_1(object sender, EventArgs e)
        {
            // Validamos que haya seleccionado un método
            if (cmbMetodo.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, selecciona un método de pago.");
                return;
            }

            // Validamos que el pago sea suficiente
            if (decimal.TryParse(txtPagaCon.Text, out decimal paga) && paga < totalAPagar)
            {
                MessageBox.Show("El monto pagado es menor al total.");
                return;
            }

            this.MetodoSeleccionado = cmbMetodo.Text;
            this.Referencia = txtComprobante.Text;
            this.PagoConfirmado = true;
            this.DialogResult = DialogResult.OK; // Esto ayuda a que el Form1 sepa que todo salió bien
            this.Close();
        }
    }
}
