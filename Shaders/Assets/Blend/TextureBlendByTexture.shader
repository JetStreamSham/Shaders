Shader "Blends/TextureBlendByTexture"
{
    Properties
    {
		_Texture1("Color1", 2D) = ""{}
		_Texture2("Color2", 2D) = ""{}
		_BlendTexture("Blend", 2D) = ""{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
				float2 uv3 : TEXCOORD2;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
				float2 uv3 : TEXCOORD2;
            };

            sampler2D _Texture1;
            sampler2D _Texture2;
            sampler2D _BlendTexture;

			float4 _Texture1_ST;
			float4 _Texture2_ST;
			float4 _BlendTexture_ST;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _Texture1);
				o.uv2 = TRANSFORM_TEX(v.uv2, _Texture2);
				o.uv3 = TRANSFORM_TEX(v.uv3, _BlendTexture);
                return o;
            }


			fixed4 frag(v2f i) : SV_Target
			{
				// sample the texture
				fixed4 texSample1 = tex2D(_Texture1,i.uv);
				fixed4 texSample2 = tex2D(_Texture2,i.uv2);
				fixed4 blendSample = tex2D(_BlendTexture,i.uv3);
				float blendValue = blendSample.r;
				fixed4 col = lerp(texSample1, texSample2,blendValue);
                return col;
            }
            ENDCG
        }
    }
}
