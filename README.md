# Study: Quantifying the impact of load forecasting accuracy on congestion management in distribution grids 

Digitalization is a global trend in energy systems and beyond. However, it is often unclear what digitalization means exactly in the context of energy systems and how the benefits of digitalization can be quantified. Providing additional information, e.g., through sensors and metering equipment, is one concrete angle where digitalization contributes. This study provides a framework to quantify the value of such additional information in distribution grids. We analyze to what extent smart meters improve the accuracy of day-ahead load forecasts and quantify the savings in congestion management costs resulting from the improved accuracy.


## Repository Content

This repository aims to contribute to the open sience community, making our data of the underlying study available the results transparentand  and replicable. 

### Code for Data Preparation

In the folder "2. Data_Preparation_IEEE33" one can find all the data required to:
- calculate the forecast errors for each node depending on the node standard deviation determined using the Monte Carlo simulation (Calculate_Different_Deviation_Error)
- calculate the resulting power flows and voltage levels considering the simulated forecast errors (Gams_file "Gata_Preprocessing)
- calculate the x% quantiles for the resulting power flos and voltage levels (Sort_PF_quantile, Sort_VL_quantile)

### Code for Comgestion Management Model

Based on the data generated in the 2. "Data_Preparation_IEEE33" folder one can use the x% quantiles of power flows and voltage levels to run the congestion management model
- the original data for our paper are uploaded at ZENONDO. URL:

## Case Study

We used the IEEE 33-node test system to model a typical distribution gird system. Using smart Meter data from more than 6300 Households, we generated real historical load time series for each node of the system. 
 
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/IEEE_Grid.svg)


![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Vergleich%20Lastrofilprognose%20SLP%20vs.%20ARIMA.svg)


![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Nodal_SD.svg)


## Project IDiNA - Intelligente Digitalisierung der Energieversorgung zur Optimierung des Netzbetriebs und zur Erhöhung der Akzeptanz“
![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/IDiNA_Projektlogo.svg)  ![](https://github.com/BTU-EnerEcon/IDiNA/blob/main/Visualization%20Results/Logo/Logo_BMWK.svg)
