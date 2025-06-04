import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Configuración de la página
st.set_page_config(page_title="Visualizaciones con Streamlit", layout="wide")

# Cargar datasets
tips = sns.load_dataset("tips")
flights = sns.load_dataset("flights")
diamonds = sns.load_dataset("diamonds").sample(1000, random_state=42)  # Para no sobrecargar
iris = sns.load_dataset("iris")

# CSS para centrar y limitar el ancho
st.markdown("""
<style>
    .center {
        display: flex;
        justify-content: center;
        align-items: center;
    }
</style>
""", unsafe_allow_html=True)

st.title("📊 Visualización de Datos con Streamlit")

# Tabs para organizar
tab1, tab2, tab3, tab4 = st.tabs([
    "📦 Boxplot (Propinas)",
    "🌡️ Heatmap (Pasajeros)",
    "💎 Violin Plot (Diamantes)",
    "🌸 Dispersión (Iris)"
])

# Gráfico 1: Boxplot
with tab1:
    st.subheader("Distribución de propinas por día")
    st.dataframe(tips.head())
    fig1, ax1 = plt.subplots(figsize=(6, 4))
    sns.boxplot(x="day", y="tip", data=tips, ax=ax1, palette="pastel")
    ax1.set_title("Propinas por Día")
    st.markdown('<div class="center">', unsafe_allow_html=True)
    st.pyplot(fig1)
    st.markdown('</div>', unsafe_allow_html=True)

# Gráfico 2: Heatmap
with tab2:
    st.subheader("Pasajeros por mes y año")
    pivot_flights = flights.pivot(index="month", columns="year", values="passengers")
    st.dataframe(pivot_flights)
    fig2, ax2 = plt.subplots(figsize=(10, 5))
    sns.heatmap(pivot_flights, annot=True, fmt="d", cmap="YlGnBu", ax=ax2)
    ax2.set_title("Pasajeros por Mes y Año")
    st.pyplot(fig2)

# Gráfico 3: Violin plot
with tab3:
    st.subheader("Precio de diamantes por tipo de corte")
    st.dataframe(diamonds[['cut', 'price']].head())
    fig3, ax3 = plt.subplots(figsize=(6, 4))
    sns.violinplot(x="cut", y="price", data=diamonds, palette="muted", ax=ax3)
    ax3.set_title("Precio de Diamantes por Corte")
    st.pyplot(fig3)

# Gráfico 4: Dispersión iris
with tab4:
    st.subheader("Relación entre largo y ancho de sépalo")
    st.dataframe(iris.head())
    fig4, ax4 = plt.subplots(figsize=(6, 4))
    sns.scatterplot(data=iris, x="sepal_length", y="sepal_width", hue="species", ax=ax4)
    ax4.set_title("Largo vs Ancho de Sépalo")
    st.pyplot(fig4)
