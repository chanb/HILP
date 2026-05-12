#!/bin/bash
#SBATCH --account=aip-schuurma
#SBATCH --time=12:00:00
#SBATCH --mem=8GB
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=1-1
#SBATCH --output=/home/chanb/scratch/code/unsupervised_rl/logs/%j.out

module load StdEnv/2023
module load python/3.10.13
module load cuda/12.9

cd /home/chanb/scratch/code/unsupervised_rl/HILP/hilp_zsrl
source .venv/bin/activate

PYTHONPATH=. python url_benchmark/train_offline.py run_group=EXP device=cuda agent=fb_ddpg agent.q_loss=False seed=0 task=point_mass_maze_reach_bottom_right expl_agent=proto load_replay_buffer=/home/chanb/scratch/datasets/unsupervised_rl/datasets/point_mass_maze/proto/replay.pt replay_buffer_episodes=5000