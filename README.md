# Study: Quantifying the impact of load forecasting accuracy on congestion management in distribution grids 

Digitalization is a global trend in energy systems and beyond. However, it is often unclear what digitalization means exactly in the context of energy systems and how the benefits of digitalization can be quantified. Providing additional information, e.g., through sensors and metering equipment, is one concrete angle where digitalization contributes. This study provides a framework to quantify the value of such additional information in distribution grids. We analyze to what extent smart meters improve the accuracy of day-ahead load forecasts and quantify the savings in congestion management costs resulting from the improved accuracy.


## Repository Content

This repository aims to contribute to the open sience community, making our data of the underlying study available and the results transparent and replicable. 

### Step1:) Code for Data Preparation

**In the folder "Data_Preparation_IEEE33" one can:**
- Find the power flows, voltage levels and sensitifity factors based on the powerplant dispatch determined in our case study as well as other tehcnical grid specification (File: "AC_IEEE_Case_Study.gdx)
- Calculate the forecast errors for each time step using the Monte Carlo simulation for each node depending on the nodal standard deviation of the errrors (File: "Calculate_Different_Deviation_Error.ipynb")
- Calculate the resulting power flows and voltage levels using the sensitifiy factors for each time step considering the simulated forecast errors (File: "Data_Preprocessing.gms")
- Calculate the x% quantiles for the resulting power flows and voltage levels for each time step(Files: "Sort_PF_quantile.py", "Sort_VL_quantile.py")

**The resulting x% quantiles of the power flows and voltage levels serve as input data for the congestion management model.**

### Step 2) Congestion Management Model

**Based on the data generated in the "Data_Preparation_IEEE33" folder one can use the x% quantiles of power flows and voltage levels to run the congestion management model
Therefor one needs:**

1) The data for the model, which are stored in the "data_case33" xlsx file and the including the:
  - the solar PV capacity factor
  - the electricity day-ahead price time series
  - the nodal demand time series
2) The power flows and voltage levels generated in the previous step
3) The data of the sensitivity factors, nominal voltage level and maximum thermal line carrying capacity (File: "AC_IEEE_Case_Study.gdx")

## Case Study

We used the IEEE 33-node test system to model a typical distribution gird system. Using smart Meter data from more than 6300 Households, we generated real historical load time series for each node of the system. 
 
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/IEEE_Grid.svg)

### Uncertainty Simulation

1) We measure the load forecasting accuracy for each nodal demand time series in the system based on a SLP forecast and a ARIMA forecast.

![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Nodal_SD.svg)

2) Then we take the standard deviation of each node to simulate a given sample of forecast errors for each node and timestep to calcaulte resulting power flows and voltage levels confidence intervalls.

![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Vergleich%20Lastrofilprognose%20SLP%20vs.%20ARIMA.svg)

3) On this basis we calculate in the congestion management model cost minimal redispatch actions and their associated costs.

## Project IDiNA - Intelligente Digitalisierung der Energieversorgung zur Optimierung des Netzbetriebs und zur Erhöhung der Akzeptanz“
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/IDiNA_Projektlogo.svg)  ![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/Logo_BMWK.svg)
