// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.22;

import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

import {ERC20PermitApprovalMsg, ERC721PermitApprovalMsg} from "../ITapToken.sol";
import {ERC721Permit} from "contracts/utils/ERC721Permit.sol"; // TODO audit

/*
__/\\\\\\\\\\\\\\\_____/\\\\\\\\\_____/\\\\\\\\\\\\\____/\\\\\\\\\\\_______/\\\\\_____________/\\\\\\\\\_____/\\\\\\\\\____        
 _\///////\\\/////____/\\\\\\\\\\\\\__\/\\\/////////\\\_\/////\\\///______/\\\///\\\________/\\\////////____/\\\\\\\\\\\\\__       
  _______\/\\\________/\\\/////////\\\_\/\\\_______\/\\\_____\/\\\_______/\\\/__\///\\\____/\\\/____________/\\\/////////\\\_      
   _______\/\\\_______\/\\\_______\/\\\_\/\\\\\\\\\\\\\/______\/\\\______/\\\______\//\\\__/\\\_____________\/\\\_______\/\\\_     
    _______\/\\\_______\/\\\\\\\\\\\\\\\_\/\\\/////////________\/\\\_____\/\\\_______\/\\\_\/\\\_____________\/\\\\\\\\\\\\\\\_    
     _______\/\\\_______\/\\\/////////\\\_\/\\\_________________\/\\\_____\//\\\______/\\\__\//\\\____________\/\\\/////////\\\_   
      _______\/\\\_______\/\\\_______\/\\\_\/\\\_________________\/\\\______\///\\\__/\\\_____\///\\\__________\/\\\_______\/\\\_  
       _______\/\\\_______\/\\\_______\/\\\_\/\\\______________/\\\\\\\\\\\____\///\\\\\/________\////\\\\\\\\\_\/\\\_______\/\\\_ 
        _______\///________\///________\///__\///______________\///////////_______\/////_____________\/////////__\///________\///__
*/

/**
 * @title TapOFTExtExec
 * @author TapiocaDAO
 * @notice Used to execute external calls from the TapOFTv2 contract. So to not use TapOFTv2 in the call context.
 */
contract TapOFTExtExec {
    /**
     * @notice Executes an ERC20 permit approval.
     * @param _approvals The ERC20 permit approval messages.
     */
    function erc20PermitApproval(ERC20PermitApprovalMsg[] calldata _approvals) public {
        uint256 approvalsLength = _approvals.length;
        for (uint256 i = 0; i < approvalsLength;) {
            IERC20Permit(_approvals[i].token).permit(
                _approvals[i].owner,
                _approvals[i].spender,
                _approvals[i].value,
                _approvals[i].deadline,
                _approvals[i].v,
                _approvals[i].r,
                _approvals[i].s
            );
            unchecked {
                ++i;
            }
        }
    }
    /**
     * @notice Executes an ERC721 permit approval.
     * @param _approvals The ERC721 permit approval messages.
     */

    function erc721PermitApproval(ERC721PermitApprovalMsg[] calldata _approvals) public {
        uint256 approvalsLength = _approvals.length;
        for (uint256 i = 0; i < approvalsLength;) {
            ERC721Permit(_approvals[i].token).permit(
                _approvals[i].spender,
                _approvals[i].tokenId,
                _approvals[i].deadline,
                _approvals[i].v,
                _approvals[i].r,
                _approvals[i].s
            );
            unchecked {
                ++i;
            }
        }
    }
}
