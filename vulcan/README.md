## Installation
```
module load StdEnv/2023
module load python/3.10.13

uv venv
uv pip install -r requirements.txt
source .venv/bin/activate
```

## Datasets
Download [exorl](https://github.com/denisyarats/exorl) datasets.
Below is the content from the repository:

We provide exploratory datasets for 6 DeepMind Control Stuite domains
| Domain | Dataset name | Available task names |
|---|---|---|
| Cartpole | `cartpole` | `cartpole_balance`, `cartpole_balance_sparse`, `cartpole_swingup`, `cartpole_swingup_sparse` |
| Cheetah | `cheetah` | `cheetah_run`, `cheetah_run_backward` |
| Jaco Arm | `jaco` | `jaco_reach_top_left`, `jaco_reach_top_right`, `jaco_reach_bottom_left`, `jaco_reach_bottom_right` |
| Point Mass Maze | `point_mass_maze` | `point_mass_maze_reach_top_left`, `point_mass_maze_reach_top_right`, `point_mass_maze_reach_bottom_left`, `point_mass_maze_reach_bottom_right`  | 
| Quadruped | `quadruped` | `quadruped_walk`, `quadruped_run` |
| Walker | `walker` | `walker_stand`, `walker_walk`, `walker_run` |


For each domain we collected datasets by running 9 unsupervised RL algorithms from [URLB](https://github.com/rll-research/url_benchmark) for total of `10M` steps. Here is the list of algorithms
| Unsupervised RL method | Name | Paper |
|---|---|---|
| APS | `aps` |  [paper](http://proceedings.mlr.press/v139/liu21b.html)|
| APT(ICM) | `icm_apt` |  [paper](https://arxiv.org/abs/2103.04551)|
| DIAYN | `diayn` |[paper](https://arxiv.org/abs/1802.06070)|
| Disagreement | `disagreement` | [paper](https://arxiv.org/abs/1906.04161) |
| ICM | `icm` | [paper](https://arxiv.org/abs/1705.05363)|
| ProtoRL | `proto` | [paper](https://arxiv.org/abs/2102.11271)|
| Random | `random` |  N/A |
| RND | `rnd` |  [paper](https://arxiv.org/abs/1810.12894) |
| SMM | `smm` |  [paper](https://arxiv.org/abs/1906.05274) |



You can download a dataset by running `./download.sh <BASE_PATH> <DOMAIN> <ALGO>`, for example to download ProtoRL dataset for point mass maze, run
```sh
./download.sh /home/username/scratch/datasets/exorl point_mass_maze proto
```
The script will download the dataset from S3 and store it under `/home/username/scratch/datasets/exorl/walker/proto/`, where you can find episodes (under `buffer`) and episode videos (under `video`).
Then, run
```sh
python hilp_zsrl/convert.py --env point_mass_maze --task reach_bottom_right --method proto --save_path /home/username/scratch/datasets/exorl
```