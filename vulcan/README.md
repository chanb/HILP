## Installation
```
module load StdEnv/2023
module load python/3.10.13
module load cuda/12.9

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


## Interactive
```
salloc --time=02:00:00 --mem=50GB --cpus-per-task=2 --gres=gpu:1 --account=aip-schuurma 

module load StdEnv/2023
module load python/3.10.13
module load cuda/12.9

cd /home/chanb/research/unsupervised_rl/HILP/hilp_zsrl
source .venv/bin/activate

# Download dataset
../vulcan/download.sh /home/chanb/scratch/datasets/unsupervised_rl point_mass_maze proto

# Generate dataset
python convert.py --env point_mass_maze --task reach_bottom_right --method proto --save_path /home/chanb/scratch/datasets/unsupervised_rl

# Run offline training
PYTHONPATH=. python url_benchmark/train_offline.py run_group=EXP device=cuda agent=fb_ddpg agent.q_loss=False seed=0 task=walker_run expl_agent=proto load_replay_buffer=/home/chanb/scratch/datasets/unsupervised_rl/datasets/point_mass_maze/proto/replay.pt replay_buffer_episodes=5000 use_wandb=False use_tb=True

```