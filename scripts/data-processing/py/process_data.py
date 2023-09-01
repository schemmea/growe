#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import os
import pandas as pd
from visualize import *
from pytablewriter import MarkdownTableWriter


DATASET = ["nextflow"]

ALGORITHM = ["afl", "semantic-zest", "syntactic-zest", "semantic-noguidance", "syntactic-noguidance"]

RANGE=7

def generate_cov_table(base_path: str):
    cov_all_data = []
    cov_valid_data = []
    for dataset in DATASET:
        cov_all_algo_data = []
        cov_valid_algo_data = []
        for algorithm in ALGORITHM:
            for idx in range(0, RANGE):
                path = os.path.join(base_path, f"{dataset}-{algorithm}-{idx}", "errorDir")
                if algorithm == "afl":
                    path = os.path.join(base_path, f"{dataset}-{algorithm}-{idx}","fuzz-results")
                if not os.path.exists(path):
                    continue
                print(f"processing: {path}")

                cov_all_path = os.path.join(path, "cov-all.log")
                if os.path.exists(cov_all_path):
                    cov_all = process_cov_data(cov_all_path)
                    cov_all_algo_data.append(len(cov_all))
                
                cov_valid_path = os.path.join(path, "cov-valid.log")
                if os.path.exists(cov_valid_path):
                    cov_valid = process_cov_data(cov_valid_path)
                    cov_valid_algo_data.append(len(cov_valid))
        
        cov_all_data.append([dataset, *cov_all_algo_data])
        cov_valid_data.append([dataset, *cov_valid_algo_data])
    writer = MarkdownTableWriter(
        headers = ["Dataset", *ALGORITHM],
        value_matrix = cov_all_data
    )
    writer.write_table()

    writer = MarkdownTableWriter(
        headers = ["Dataset", *ALGORITHM],
        value_matrix = cov_valid_data
    )
    writer.write_table()

def generate_graph(base_path: str, outdirname: str):
    for dataset in DATASET:
        time_based_plot_data = []
        count_based_plot_data = []
        cov_data = {
            "algo": [],
            "type": [],
            "value": []
        }
        for algorithm in ALGORITHM:
            time_based_data_per_algo = []
            count_based_data_per_algo = []
            for idx in range(0, RANGE):
                path = os.path.join(base_path, f"{dataset}-{algorithm}-{idx}", "errorDir")
                if algorithm == "afl":
                    path = os.path.join(base_path, f"{dataset}-{algorithm}-{idx}","fuzz-results")
                if not os.path.exists(path):
                    continue
                print(f"processing: {path}")

                # plot_data from jqf afl run differs from other 
                if not algorithm == "afl":
                    time_based_data, count_based_data = process_plot_data(path,algorithm)
                    time_based_data_per_algo.append(time_based_data)
                    count_based_data_per_algo.append(count_based_data)

                cov_all_path = os.path.join(path, "cov-all.log")
                if os.path.exists(cov_all_path):
                    cov_all = process_cov_data(cov_all_path)
                    cov_data["algo"].append(algorithm)
                    cov_data["type"].append("all")
                    cov_data["value"].append(len(cov_all))
                
                cov_valid_path = os.path.join(path, "cov-valid.log")
                if os.path.exists(cov_valid_path):
                    cov_valid = process_cov_data(cov_valid_path)
                    cov_data["algo"].append(algorithm)
                    cov_data["type"].append("valid")
                    cov_data["value"].append(len(cov_valid))

            time_based_plot_data.extend([d for d in time_based_data_per_algo])
            count_based_plot_data.extend([d for d in time_based_data_per_algo])
        if not time_based_plot_data:
            continue
        out_folder = os.path.join(base_path, outdirname)
        print(out_folder)
        if not os.path.exists(out_folder):
            os.mkdir(out_folder)
        time_based_plot_data = pd.concat(time_based_plot_data, ignore_index=True, sort=False)
        count_based_plot_data = pd.concat(count_based_plot_data, ignore_index=True, sort=False)
        generate_total_coverage_bar(os.path.join(out_folder, f"{dataset}-cov.pdf"), cov_data)
        generate_total_inputs_over_time(os.path.join(out_folder, f"{dataset}-total_inputs.pdf"), time_based_plot_data)
        generate_valid_coverage_over_time(os.path.join(out_folder, f"{dataset}-valid-cov-time.pdf"), time_based_plot_data)
        generate_all_coverage_over_time(os.path.join(out_folder, f"{dataset}-all-cov-time.pdf"), time_based_plot_data)
        generate_valid_coverage_over_total_inputs(os.path.join(out_folder, f"{dataset}-valid-cov-input.pdf"), count_based_plot_data)
        generate_all_coverage_over_total_inputs(os.path.join(out_folder, f"{dataset}-all-cov-input.pdf"), count_based_plot_data)


def main():
    # path = "/home/alena/source/growe/experiments_repro/"
    path = sys.argv[1]
    outdirname="figs"
    if len(sys.argv) >= 3:
        outdirname = sys.argv[2]
    # generate_cov_table(path)
    generate_graph(path, outdirname)

if __name__ == "__main__":
    main()
