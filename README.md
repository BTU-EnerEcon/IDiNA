# Study: Quantifying the impact of load forecasting accuracy on congestion management in distribution grids 

Digitalization is a global trend in energy systems and beyond. However, it is often unclear what digitalization means exactly in the context of energy systems and how the benefits of digitalization can be quantified. Providing additional information, e.g., through sensors and metering equipment, is one concrete angle where digitalization contributes. This study provides a framework to quantify the value of such additional information in distribution grids. We analyze to what extent smart meters improve the accuracy of day-ahead load forecasts and quantify the savings in congestion management costs resulting from the improved accuracy.


## Repository Content

This repository aims to contribute to the open sience community, making our data of the underlying study available and the results transparent and replicable. 

### Code for Data Preparation

**In the folder "2. Data_Preparation_IEEE33" one can find:**
- the power flows, voltage levels and sensitifity facotrs based on the powerplant dispatch determined in our case study as well as other tehcnical grid specification (File: "AC_IEEE_Case_Study.gdx)
- calculate the forecast errors for each time step using the Monte Carlo simulation for each node depending on the nodal standard deviation of the errrors (File: "Calculate_Different_Deviation_Error.ipynb")
- calculate the resulting power flows and voltage levels using the sensitifiy factors for each time step considering the simulated forecast errors (File: "Gata_Preprocessing.gms")
- calculate the x% quantiles for the resulting power flows and voltage levels for each time step(Files: "Sort_PF_quantile.py", "Sort_VL_quantile.py")

**The resulting x% quantiles of the power flows and voltage levels serve as input data for the congestion management model.**

### Code for Congestion Management Model

**Based on the data generated in the 2. "Data_Preparation_IEEE33" folder one can use the x% quantiles of power flows and voltage levels to run the congestion management model**
- one needs:
1) the data for the model, which are stored in the "data_case33" xlsx file and the including the:
  - the solar PV capacity factor
  - the electricity day-ahead price time series
2) the power flows and voltage levels generated in the previous step
- the data for our study are uploaded at ZENONDO. URL:
3) the data of the sensitivity factors, nominal voltage level and maximum thermal line carrying capacity (File: "AC_IEEE_Case_Study.gdx")

## Case Study

We used the IEEE 33-node test system to model a typical distribution gird system. Using smart Meter data from more than 6300 Households, we generated real historical load time series for each node of the system. 
 
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/IEEE_Grid.svg)


![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Vergleich%20Lastrofilprognose%20SLP%20vs.%20ARIMA.svg)


## Case Study Results

![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Nodal_SD.svg)


## Project IDiNA - Intelligente Digitalisierung der Energieversorgung zur Optimierung des Netzbetriebs und zur Erhöhung der Akzeptanz“
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/IDiNA_Projektlogo.svg)  ![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/Logo_BMWK.svg)
