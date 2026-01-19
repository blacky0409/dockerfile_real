# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# The workflow includes custom nodes from an unknown registry but none provided an aux_id (GitHub repo)
# so they cannot be installed automatically. Please provide GitHub repos or registry IDs for these
# custom nodes so they can be cloned or installed. The listed nodes (no aux_id found):
# - TextEncodeQwenImageEditPlus
# - LoraLoaderModelOnly
# - LoraLoaderModelOnly
# - ConditioningZeroOut
# - GetImageSize
# - ImageScaleToTotalPixels
# - LoraLoaderModelOnly
# - TextEncodeQwenImageEditPlus
# - ConditioningZeroOut
# If you can provide GitHub repo names for any of the above, they can be cloned into /comfyui/custom_nodes/.

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2509_fp8_e4m3fn.safetensors --relative-path models/diffusion_models --filename qwen_image_edit_2509_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors --relative-path models/clip --filename qwen_2.5_vl_7b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Edit-2509/Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors --relative-path models/loras --filename Qwen-Image-Edit-2509-Lightning-4steps-V1.0-bf16.safetensors
RUN comfy model download --url https://huggingface.co/datasets/dubsta/xmas/blob/main/extract-outfit_v3.safetensors --relative-path models/loras --filename extract-outfit_v3.safetensors
RUN comfy model download --url https://huggingface.co/datasets/dubsta/xmas/blob/main/clothtransfer.safetensors --relative-path models/loras --filename clothtransfer.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
