python -m llava.eval.model_vqa_loader \
    --model-path /root/autodl-tmp/llava-v1.5-7b \
    --question-file /root/autodl-tmp/eval/MME/llava_mme_test.jsonl \
    --image-folder /root/autodl-tmp/eval/MME/MME_Benchmark_release_version \
    --answers-file /root/autodl-tmp/eval/MME/answers/llava-v1.5-7b.jsonl \
    --temperature 0 \
    --conv-mode vicuna_v1 \
