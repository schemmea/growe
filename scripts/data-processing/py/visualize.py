from pyexpat.errors import XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF
import sys
import os
from typing import Dict, List, Any
import numpy as np
import pandas as pd
import seaborn as sns


def p2f(value: str) -> float:
    return float(value.strip('%'))


def process_plot_data(path: str, algorithm: str, reindexsteps: int = 10) -> pd.DataFrame:
    ps=os.path.join(path, 'plot_data')
    print(ps)
    time_axis = "# unix_time"
    threshhold=3600 #seconds	
    if algorithm == "afl":
        data = pd.read_csv(ps, sep=",", skipinitialspace=True,
                       converters={"valid_cov": p2f, "map_size": p2f})
    else:
        data = pd.read_csv(ps, sep=",", skipinitialspace=True)

    if data.empty: return None, None

    data[time_axis] -= data[time_axis][0]
    data['total_inputs'] = data['valid_inputs'] + data['invalid_inputs']
    data['total_inputs'] -= data["total_inputs"][0]
    x_axis = "total_inputs"
    # experiment_name = os.path.basename(path)
    #algorithm = "-".join(experiment_name.split('-')[1:-2])

    data = data[data[time_axis] < threshhold]
    x_axis = time_axis
    time_based_data = data.copy().drop_duplicates(
        keep='first', subset=[x_axis])
    time_based_data = time_based_data.set_index(x_axis).reindex(
       range(1, time_based_data[x_axis].max(), reindexsteps)).interpolate().reset_index()
    time_based_data['algorithm'] = [algorithm] * time_based_data.shape[0]


    x_axis = "total_inputs"
    count_based_data = data.copy().drop_duplicates(
        keep='first', subset=[x_axis])
    count_based_data = count_based_data.set_index(x_axis).reindex(
       range(0, count_based_data[x_axis].max(), reindexsteps)).interpolate().reset_index()
    count_based_data['algorithm'] = [algorithm] * count_based_data.shape[0]


    return time_based_data, count_based_data

def process_cov_data(path: str) -> List[str]:
    with open(path) as f:
        return f.readlines()

def generate_plot_data_base(path: str, data: pd.DataFrame, x_axis: str, y_axis: str, errorbarname: str = 'se'):
    print(x_axis, y_axis)
    if errorbarname == 'se':
        axis = sns.lineplot(x=x_axis, y=y_axis, hue='algorithm', errorbar="se", hue_order=sorted(data['algorithm'].unique()), data=data)
    elif errorbarname == 'sd':
        axis = sns.lineplot(x=x_axis, y=y_axis, hue='algorithm', errorbar=("sd",95), hue_order=sorted(data['algorithm'].unique()), data=data)    
    fig = axis.get_figure()
    fig.savefig(path)
    fig.clf()

def generate_valid_coverage_over_time(path: str, data: pd.DataFrame,  errorbarname: str = 'se'):
    generate_plot_data_base(path, data, "# unix_time", "valid_covered_probes", errorbarname)

def generate_all_coverage_over_time(path: str, data: pd.DataFrame,  errorbarname: str = 'se'):
    generate_plot_data_base(path, data, "# unix_time", "all_covered_probes", errorbarname)

def generate_total_inputs_over_time(path: str, data: pd.DataFrame,  errorbarname: str = 'se'):
    generate_plot_data_base(path, data, "# unix_time", "total_inputs", errorbarname)

def generate_valid_coverage_over_total_inputs(path: str, data: pd.DataFrame,  errorbarname: str = 'se'):
    generate_plot_data_base(path, data, "total_inputs", "valid_covered_probes", errorbarname)

def generate_all_coverage_over_total_inputs(path: str, data: pd.DataFrame,  errorbarname: str = 'se'):
    generate_plot_data_base(path, data, "total_inputs", "all_covered_probes", errorbarname)

def show_values_on_bars(axs):
    def _show_on_single_plot(ax):
        for p in ax.patches:
            _x = p.get_x() + p.get_width() / 2
            _y = p.get_y() + p.get_height() + 10
            value = str(int(p.get_height()))
            ax.text(_x, _y, value, ha="center")

    if isinstance(axs, np.ndarray):
        for _, ax in np.ndenumerate(axs):
            _show_on_single_plot(ax)
    else:
        _show_on_single_plot(axs)

def generate_total_coverage_bar(path: str, data: Dict[str, List[Any]]):
    axis = sns.barplot(x="type", y="value", hue="algo", data=data)
    show_values_on_bars(axis)
    fig = axis.get_figure()
    fig.savefig(path)
    fig.clf()



