from alembic import command
from alembic.config import Config
import os


def run_alembic_upgrade():
    # 获取 Alembic 配置文件路径
    alembic_cfg = Config(os.path.join(
        os.path.dirname(__file__), 'alembic.ini'))

    # 执行升级命令，相当于在命令行中运行 `alembic upgrade head`
    command.upgrade(alembic_cfg, 'head')
