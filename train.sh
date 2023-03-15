exp_dir=$1
model_arch=$2

fairseq-train $exp_dir/final_bin \
--max-source-positions=256 \
--max-target-positions=256 \
--max-update=1000000 \
--save-interval-updates=1000 \
--arch=$model_arch \
--activation-fn gelu \
--criterion=label_smoothed_cross_entropy \
--source-lang=SRC \
--target-lang=TGT \
--lr-scheduler=inverse_sqrt \
--label-smoothing=0.1 \
--optimizer adam \
--adam-betas "(0.9, 0.98)" \
--clip-norm 1.0 \
--warmup-init-lr 1e-07 \
--lr 5e-4 \
--warmup-updates 4000 \
--dropout 0.2 \
--save-dir  $exp_dir/model \
--keep-last-epochs 5 \
--keep-interval-updates 3 \
--patience 10 \
--skip-invalid-size-inputs-valid-test \
--fp16 \
--user-dir model_configs \
--update-freq=32 \
--distributed-world-size 4 \
--num-workers 24 \
--max-tokens 2048 \
--eval-bleu \
--eval-bleu-args "{\"beam\": 1, \"lenpen\": 1.0, \"max_len_a\": 1.2, \"max_len_b\": 10}" \
--eval-bleu-detok moses \
--eval-bleu-remove-bpe sentencepiece \
--eval-bleu-print-samples \
--best-checkpoint-metric bleu \
--maximize-best-checkpoint-metric \
--wandb-project m2m_zs \
--task translation
